<?php

/*
WHAT IS THIS?
Automated backup script that pulls the database, compresses, and syncs that plus
any user uploaded files over to an S3 bucket. Designed for Platform.sh

SETUP:
- Ensure that monolog is available, if not, add via composer.json
- Add the AWS PHP SDK (aws/aws-sdk-php) and Platform.sh config reader (platformsh/config-reader) via composer.json
- Ensure that AWS AMI user is created and has access to read/write the ftusa-site-backups S3 bucket
- Add backups directory to .platform.app.yaml
    mounts:
        "/backups": "shared:files/backups"
- Add environmental variables in Platform.sh
    - env:AWS_ACCESS_KEY_ID
    - env:AWS_SECRET_ACCESS_KEY
    - env:LOGGLY_TOKEN (note: get from loggly > source setup > tokens)
    - env:FILES_TO_BACKUP (optional: only add if you have user uploaded files to back up -- if added use, full path [e.g. /app/storage/app/uploads])
- Deploy and test using: php ./jobs/db_backup.php
- Add cron task to .platform.app.yml
    db_backup:
        spec: "0 0 * * *"
        cmd: "php ./jobs/db_backup.php"

Adapted by https://github.com/kaypro4 from an example by https://github.com/JGrubb - Thanks John!
*/

$home_dir = getenv('PLATFORM_DIR');

require __DIR__ . '/../../../vendor/autoload.php';

$bucket = 'tn-mysql-transfer';
$fixedBranch = strtolower(preg_replace('/[\W\s\/]+/', '-', getenv('PLATFORM_BRANCH')));
$baseDirectory = 'platform/' . getenv('PLATFORM_APPLICATION_NAME') . '/' . $fixedBranch;
$branchAndProject = getenv('PLATFORM_APPLICATION_NAME') . ' > ' . $fixedBranch;

use Monolog\Logger;
use Monolog\Handler\LogglyHandler;
use Monolog\Formatter\LogglyFormatter;

$logger = new Logger('backup_logger');
$logger->pushHandler(new LogglyHandler(getenv('LOGGLY_TOKEN') . '/tag/backup_logger', Logger::INFO));

$s3 = new Aws\S3\S3Client([
    'version' => 'latest',
    'region'  => 'eu-west-1',
    'credentials' => [
        'key'    => getenv('AWS_ACCESS_KEY_ID'),
        'secret' => getenv('AWS_SECRET_ACCESS_KEY')
    ]
]);

if(isset($s3)) {
  $objects = $s3->getIterator('ListObjects', array(
    "Bucket" => $bucket,
  ));
  
  // initialize with nothing
  $most_recent = [];
  
  foreach ($objects as $object) {
  
      // DateTime result
    $last_modified = $object['LastModified'];
  
    if (empty($most_recent['LastModified']) || $last_modified > $most_recent['LastModified']) {
      if(strpos($object['Key'], $fixedBranch . '/database') > 0) {
        $most_recent = $object;
      }
    }
  }

  if(!empty($most_recent['LastModified'])) {
    try {
      // Get the object.
      $result = $s3->getObject([
          'Bucket' => $bucket,
          'Key'    => $most_recent['Key']
      ]);
      print "Fetching bucket: {$bucket}\n";
      file_put_contents ('/tmp/import.sql.gz', $result['Body']);
  
      $psh = new Platformsh\ConfigReader\Config();
      if($psh->isValidPlatform()) {
          //backup the db
          try {
              if ($psh->hasRelationship('database')) {
                  $database = $psh->credentials('database');
  
                  putenv("MYSQL_PWD={$database['password']}");
                  print "Dropping database: migration\n";
                  system("mysql -h {$database['host']} -u {$database['username']} -p{$database['password']} --silent --skip-column-names -e \"SHOW TABLES\" migration | xargs -L1 -I% echo 'SET FOREIGN_KEY_CHECKS = 0; DROP TABLE %; SET FOREIGN_KEY_CHECKS = 1;' | mysql -h {$database['host']} -u {$database['username']} -p{$database['password']} -v migration");
                  print "Importing database: migration\n";
                  system("zcat /tmp/import.sql.gz | mysql -h {$database['host']} -u {$database['username']} migration");
                  print "Completed! \n";
              }
            } catch (Exception $e) {
              print("Error: " + $e->getMessage());
              $logger->addError("Database backup error for $branchAndProject: " . $e->getMessage());
            }
          } 
      } catch (S3Exception $e) {
        echo $e->getMessage() . PHP_EOL;
    }
  }
}

