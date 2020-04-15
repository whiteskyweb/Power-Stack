<?php

// Define a nested array of migrations to run
$migration_mapping = [
  'migrate_user' => [
    'users',
    'usersen',
    'usersde',
    'usersfr'
  ],
  'migrate_taxonomy' => [
    'termsmigrate',
    'frtermsmigrate',
    'determsmigrate'
  ],
  'migrate_content_flight' => [
    'flight',
    'flight_en',
    'flight_fr',
    'flight_de'
  ],
  'migrate_content_package' => [
    'package',
    'package_en',
    'package_fr',
    'package_de',
  ],
  'migrate_content_travelguide' => [
    'travelguide',
    'travelguide_en',
    'travelguide_de',
    'travelguide_fr'
  ],
  'migrate_content_tour' => [
    'tourmigrate',
    'tourmigrate_en',
    'tourmigrate_fr',
    'tourmigrate_de'
  ],
  'migrate_content_holiday' => [
    'holidaymigrate',
    'holidaymigrate_en',
    'holidaymigrate_fr',
    'holidaymigrate_de'
  ],
  'migrate_content_article' => [
    'article',
    'article_en',
    'article_fr',
    'article_de'
  ],
  'migrate_content_blog' => [
    'blog',
    'blog_en',
    'blog_fr',
    'blog_de'
  ],
  'migrate_content_hotel' => [
    'hotelmigrate'
  ]
];

foreach ($migration_mapping as $migration_group => $migrations) {

  // Enable migration module
  print("Starting migration for: {$migration_group}\n");
  print("Installing module:  {$migration_group}\n");
  system("drush en {$migration_group} -y");

  // Run all migrations defined
  foreach($migrations as $migration) {
    print("Running:  {$migration}\n");
    system("drush mim {$migration} --update --feedback='10 items'");
  }

  // Uninstall modules
  print("Finish migration for: {$migration_group}\n");
  print("Uninstalling module:  {$migration_group}\n");
  system("drush pm-uninstall {$migration_group} -y");
}