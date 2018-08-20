{assign var="today_string" value=$smarty.now|date_format:"%Y%m%d"}
{assign var="footer_string" value=$settings.footer_prefix|cat:$creditor.identifier|cat:$today_string|cat:"01"}
{assign var="footer_string" value=$footer_string|str_pad:41:' ':1}
{*assign var="counter_string" value=$mycounter|str_pad:15:'0':0*}
{assign var="counter_string" value=$nbtransactions|str_pad:15:'0':0}
{assign var="footer_string" value=$footer_string|cat:$counter_string}
{*assign var="amount_string" value=$sum_amount_foreach|str_pad:14:'0':0*}
{assign var="amount_string" value=$total|substr:0:-3|str_pad:14:'0':0}
{assign var="footer_string" value=$footer_string|cat:$amount_string|str_pad:96:'0':1}
{*
	----- we need to do some math to get the correct length because of special characters and str_pad cannot deal with them -----
*}
{assign var="footer_string_len2" value=$footer_string|mb_strlen:'UTF-8'}
{assign var="footer_string_len3" value=$footer_string|strlen}
{assign var="footer_string_len4" value=$settings.characters_per_row-$footer_string_len2}
{assign var="footer_len_final" value=$footer_string_len4+$footer_string_len3}
{$footer_string|str_pad:$footer_len_final:' ':1}
