{* 
	----- we need mycounter also in the footer and I had some problems with counter ----- 
*}
{assign var="mycounter" value=0}
{* 
	----- we need the total amount sum also in the footer ----- 
*}
{assign var="sum_amount_foreach" value=0}
{* 
	----- we need the due date also in the footer ----- 
*}
{assign var="duedate" value='1900-01-01'}
{*
	----- lets start the loop -----
*}
{foreach from=$contributions item="contribution" name="recur_contr"}
{assign var="sum_amount_foreach" value=$sum_amount_foreach+$contribution.total_amount}
{assign var="mycounter" value=$mycounter+1}
{assign var="my_counter_string" value=$mycounter|str_pad:10:'0':0}
{*assign var="my_counter_string" value=$nbtransactions|str_pad:10:'0':0*}
{assign var="details_string" value="88"|cat:$my_counter_string}
{assign var="total_amount_string" value=$contribution.total_amount|replace:'.':''|replace:',':''|replace:' ':''|str_pad:16:'0':0}
{assign var="details_string" value=$details_string|cat:$total_amount_string|str_pad:29:'0':1}
{assign var="details_string" value=$details_string|cat:$contribution.currency|str_pad:33:' ':1}
{assign var="contribution_detail_string" value=$contribution.contribution_id|str_pad:9:'0':0|cat:$contribution.membership_id}
{assign var="details_string" value=$details_string|cat:$contribution_detail_string|str_pad:62:' ':1}
{assign var="iban_string" value=$contribution.iban|substr:4:24|regex_replace:"/00000000$/":''}
{assign var="details_string" value=$details_string|cat:$iban_string|str_pad:86:' ':1}
{assign var="contact_string" value=$contribution.display_name|cat:' '|cat:$contribution.street_address|cat:' '|cat:$contribution.postal_code|cat:' '|cat:$contribution.city|mb_substr:0:32:"UTF-8"}
{*
	----- we need to do some math to get the correct length because of special characters and str_pad cannot deal with them -----
*}
{assign var="contact_string_len1" value=40}
{assign var="contact_string_len2" value=$contact_string|mb_strlen:'UTF-8'}
{assign var="contact_string_len3" value=$contact_string|strlen}
{assign var="contact_string_len4" value=$contact_string_len1-$contact_string_len2}
{assign var="contact_len_final" value=$contact_string_len4+$contact_string_len3}
{*
	----- now we use $contact_len_final for the str_pad of $contact_string -----
*}
{assign var="contact_string" value=$contact_string|str_pad:$contact_len_final:' ':1}
{assign var="details_string" value=$details_string|cat:$contact_string}
{*
	----- add 000 to the line -----
*}
{assign var="details_string" value=$details_string|cat:"000"}
{*
	----- and again some math for our final line for our fixed line export -----
*}
{assign var="contact_string_len2" value=$contact_string|mb_strlen:'UTF-8'}
{assign var="contact_string_len3" value=$contact_string|strlen}
{assign var="contact_string_len4" value=$settings.characters_per_row-$contact_string_len2}
{assign var="contact_len_final" value=$contact_string_len4+$contact_string_len3}
{*

*}
{$details_string|str_pad:$contact_len_final:' ':1}
{/foreach}