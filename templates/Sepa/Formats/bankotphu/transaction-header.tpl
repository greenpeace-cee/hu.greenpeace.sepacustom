{*
	----- fixed width header -----
*}
{assign var="today_string" value=$smarty.now|date_format:"%Y%m%d"}
{*
	@todo: the last |cat:"01" could be version number
*}
{assign var="header_string" value=$settings.header_prefix|cat:$creditor.identifier|cat:$today_string|cat:"01"}
{assign var="header_string" value=$header_string|str_pad:41:' ':1}
{assign var="collection_date_string" value=$group.collection_date|crmDate:"%Y%m%d"|str_pad:24:'0':2}
{assign var="header_string" value=$header_string|cat:$collection_date_string|str_pad:91:' ':1}
{assign var="iban_string" value=$creditor.iban|substr:4:24|regex_replace:"/00000000$/":''|str_pad:24:' ':1}
{assign var="header_string" value=$header_string|cat:$iban_string|str_pad:115:' ':1}
{assign var="header_string" value=$header_string|cat:$settings.creditor_name}
{*
	----- we need to do some math to get the correct length because of special characters and str_pad cannot deal with them -----
*}
{assign var="header_string_len2" value=$header_string|mb_strlen:'UTF-8'}
{assign var="header_string_len3" value=$header_string|strlen}
{assign var="header_string_len4" value=$settings.characters_per_row-$header_string_len2}
{assign var="header_len_final" value=$header_string_len4+$header_string_len3}
{$header_string|str_pad:$header_len_final:' ':1}
