<?php


/**
 * @file
 * Enables modules and site configuration for a standard site installation.
 */

use Drupal\contact\Entity\ContactForm;
use Drupal\Core\Form\FormStateInterface;

/**
 * Implements hook_form_FORM_ID_alter() for install_configure_form().
 *
 * Allows the profile to alter the site configuration form.
 */
function power_stack_distro_form_install_select_language_form_alter(&$form, FormStateInterface $form_state) {
  $form['select_admin_theme_profile'] = [
    '#type' => 'radios',
    '#title' => t('Choose colour scheme'),
    '#default_value' => 'brighton',
    '#options' => [
      'brighton' => t('Brighton'),
      'san-francisco' => t('San Francisco'),
    ],
  ];
  $form['#submit'][] = 'power_stack_distro_form_install_select_language_submit';
}

function power_stack_distro_form_install_select_language_submit(&$form, FormStateInterface $form_state) {
  if (!empty($form_state->getValue('select_admin_theme_profile'))) {
    setrawcookie('Drupal.visitor.theme_profile', rawurlencode($form_state->getValue('select_admin_theme_profile')), REQUEST_TIME + 31536000, '/');
  }
}

function power_stack_distro_form_install_configure_form_alter(&$form, FormStateInterface $form_state) {
  $form['#submit'][] = 'power_stack_distro_form_install_configure_form_submit';
}

function power_stack_distro_form_install_configure_form_submit(&$form, FormStateInterface $form_state) {

  if (isset($_COOKIE['Drupal_visitor_theme_profile'])) {
    $theme_profile = \Drupal::configFactory()->getEditable('seaside_admin.settings');
    $theme_profile->set('seaside_admin_color_profile', $_COOKIE['Drupal_visitor_theme_profile'])->save(TRUE);
    user_cookie_delete('theme_profile');
  }
}

function power_stack_distro_install_tasks_alter(&$tasks, $install_state) {

  // Set labels for installer
  $tasks['install_select_language']['display_name'] = t('Setup');
  $tasks['install_verify_requirements']['display_name'] = t('Check server');
  $tasks['install_settings_form']['display_name'] = t('Configure database');
  $tasks['install_profile_modules']['display_name'] = t('Install');
}