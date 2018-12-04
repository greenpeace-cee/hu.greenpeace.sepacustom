<?php
/*-------------------------------------------------------+
| Project 60 - SEPA direct debit                         |
| Copyright (C) 2016-2018                                |
| Author: @scardinius                                    |
+--------------------------------------------------------+
| This program is released as free software under the    |
| Affero GPL license. You can redistribute it and/or     |
| modify it under the terms of this license which you    |
| can read by viewing the included agpl.txt or online    |
| at www.gnu.org/licenses/agpl.html. Removal of this     |
| copyright header is strictly prohibited without        |
| written permission from the original author(s).        |
+--------------------------------------------------------*/

class CRM_Sepa_Logic_Format_bankotphu extends CRM_Sepa_Logic_Format {

  /**
   * Apply string encoding
   * for more information why we cannot use UTF-8 please see RM #1648
   *
   * @param string $content
   *
   * @return mixed
   */
  public function characterEncode($content) {
    return iconv('UTF-8', 'WINDOWS-1252//TRANSLIT//IGNORE', $content);
  }

  /**
   * gives the option of setting extra variables to the template
   */
  public function assignExtraVariables($template) {
    $template->assign('settings', array(
      'creditor_name' => 'DGYGREENPEACE MAGYARORSZÁG EGYESÜLE',
      'characters_per_row' => 178,
      'header_prefix' => '80102O',
      'footer_prefix' => '88888O'
    ));
  }

  /**
   * Lets the format add extra information to each individual
   *  transaction (contribution + extra data)
   */
  public function extendTransaction(&$txn, $creditor_id) {
	  $contribution_recur_id = $txn["contribution_recur_id"];
    $result = CRM_Core_DAO::executeQuery("select m.entity_id as membership_id from civicrm_value_membership_payment m where m.membership_recurring_contribution = " . $contribution_recur_id);
    while ($result->fetch()) {
      $txn['membership_id'] = $result->membership_id;
    }
    // set display_name in original encoding
    $result = CRM_Core_DAO::executeQuery("select display_name from civicrm_contact where id = %0", [[$txn['contact_id'], 'Integer']]);
    while ($result->fetch()) {
      $txn['display_name'] = $result->display_name;
    }
	  return $txn;
  }

  public function getDDFilePrefix() {
    return 'DD';
  }

  /**
   * The System allows importing a file containing alphanumeric characters and the following
   * characters ( ).,/:;\+!@#$&*{}[]?=' "
   */
  public function getFilename($variable_string) {
	  $filename = 'U18178883' . date('d') .  substr($variable_string, -2) . '.txt' . '-' . date('Ymd') . substr($variable_string, 2, 1) . '.txt';
	  return $filename;
  }
}
