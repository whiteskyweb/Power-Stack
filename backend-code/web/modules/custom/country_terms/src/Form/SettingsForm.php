<?php

namespace Drupal\country_terms\Form;

use Drupal\Core\Form\ConfigFormBase;
use Drupal\Core\Form\FormStateInterface;
use Drupal\taxonomy\Entity\Term;

/**
 * Configure Country terms settings for this site.
 */
class SettingsForm extends ConfigFormBase {

  /**
   * {@inheritdoc}
   */
  public function getFormId() {
    return 'country_terms_settings';
  }

  /**
   * {@inheritdoc}
   */
  protected function getEditableConfigNames() {
    return ['country_terms.settings'];
  }

  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state) {
    $form['iso'] = [
      '#type' => 'textfield',
      '#title' => $this->t('ISO 2'),
      '#default_value' => $this->config('country_terms.settings')->get('example') ?: 'US',
    ];
    return parent::buildForm($form, $form_state);
  }

  /**
   * {@inheritdoc}
   */
  public function validateForm(array &$form, FormStateInterface $form_state) {
    if (strlen($form_state->getValue('iso')) != 2 && strlen($form_state->getValue('iso') != 0)) {
      $form_state->setErrorByName('example', $this->t('The value is not correct.'));
    }
    parent::validateForm($form, $form_state);
  }

  /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state) {

    $this->config('country_terms.settings')
      ->set('example', $form_state->getValue('iso'))
      ->save();

    $client = \Drupal::service('http_client_manager.factory')->get('country_terms_services');

    if(empty($form_state->getValue('iso'))) {
      // Update all countries
      $countries = $client->getAllCountries();
      foreach ($countries as $country) {
        $this->setCountry($country);
      }
    }
    else {
      // update single country
      $country = $client->getCountry(['iso' => $form_state->getValue('iso')]);
      $this->setCountry($country);
    }

    parent::submitForm($form, $form_state);
  }

  private function setCountry($country) {
    $vocab = 'countries';

    if(!empty($country['name'])) {

      $term_name = $country['name'];

      $term = \Drupal::entityTypeManager()
        ->getStorage('taxonomy_term')
        ->loadByProperties(['name' => $term_name, 'vid' => $vocab]);
      if (!empty($term)) {
        $this->updateTerm($term, $country);
      }
      else {
        $this->createTerm($vocab, $country);
      }

    }
  }

  private function createTerm($vocab, $data) {
    $term_name = $data['name'];

    $term = Term::create([
      'name' => $term_name,
      'field_iso_2' => $data['alpha2Code'],
      'vid' => $vocab,
    ]);
    $term->save();
  }

  private function updateTerm($term, $data) {
    $term = reset($term);

    $term->set('name', $data['name']);

    $term->set('field_iso_2', $data['alpha2Code']);
    $term->save();
  }

}
