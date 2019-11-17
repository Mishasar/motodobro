<?php

class formpd4{

var $firm = "Моя фирма название";
var $innpol = "0123456789";
var $nsch = "01234567890123456789";
var $bank = "Сберегательный банк России";
var $bik = "012345678";
var $korsch = "01234567890123456789";
var $nazn = "Оплата заказа № 1345";
var $kodplat = "PIN-0001";
var $fio = "Фамилия Имя Отчество плательщика";
var $address = "ул. Ленина д.1. кв.1";
var $summ = "123.45";
var $uslug = "3.99";
var $date = "01.01.08";

//function formpd4(){echo "Init 1";}
function formpd4($param){
if(isset($param)){
$this->firm = $param['firm'];
$this->innpol = $param['innpol'];
$this->nsch = $param['nsch'];
$this->bank = $param['bank'];
$this->bik = $param['bik'];
$this->korsch = $param['korsch'];
$this->nazn = $param['nazn'];
$this->kodplat = $param['kodplat'];
$this->fio = $param['fio'];
$this->address = $param['address'];
$this->summ = $param['summ'];
$this->uslug = $param['uslug'];
$this->date = $param['date'];
}


}

function printform(){
echo "<html lang=ru>";
echo "<head>";
echo "<title>Форма ПД-4</title>";
echo "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>";
//#############################################STYLES
echo "<style>";
echo "body {font-family: sans-serif;font-size: 8pt;background-color: white;}";
echo "table {	font-family: sans-serif;font-size: 8pt;}";
echo ".ramka {border-top: black 1px dotted;border-bottom: black 1px dotted;border-left: black 1px dotted;border-right: black 1px dotted;}";
echo ".linev {border-left: black 2px solid;}";
echo ".lineh {border-bottom: black 2px solid;}";
echo ".linevh {border-bottom: black 2px solid;border-left: black 2px solid;}";
echo ".t10b {font-weight: bold;font-size: 10pt;font-family: 'Times New Roman', serif;}";
echo ".h8b {font-weight: bold;font-size: 8pt;font-family: Arial, sans-serif;border-bottom: black 1px solid;text-align: center;}";
echo ".line_b		{BORDER-BOTTOM: black 1px solid; FONT-SIZE: 7pt; FONT-WEIGHT: bold}";
echo ".line_t		{BORDER-TOP: black 1px solid; FONT-SIZE: 7pt; FONT-WEIGHT: bold}";
echo ".line_r {border-right: black 1px solid;font-weight: bold;}";
echo ".line_l		{BORDER-LEFT: black 1px solid; FONT-SIZE: 7pt; FONT-WEIGHT: bold}";
echo ".line_lbt {border-left: black 1px solid;border-bottom: black 1px solid;border-top: black 1px solid;font-weight: bold;}";
echo ".line_lbtr {border-left: black 1px solid;border-bottom: black 1px solid;border-top: black 1px solid;border-right: black 1px solid;font-weight: bold;}";
echo ".t6n		{FONT-SIZE: 6.5pt; FONT-FAMILY: 'Times New Roman', serif}";
echo ".t7n		{FONT-SIZE: 7.5pt; FONT-FAMILY: 'Times New Roman', serif}";
echo ".t8n		{FONT-SIZE: 8.5pt; FONT-FAMILY: 'Times New Roman', serif}";
echo ".spc		{FONT-SIZE: 1pt}";
//#############################################END STYLES
echo "</style>";

echo "</head>";
echo "<body>";

//#############################################FORM

echo "<table border=0 cellspacing=0 cellpadding=0 align=center><tr><td>";
echo "<table class=ramka border=0 cellspacing=0 cellpadding=0 align=center>";
echo "<tr>";
echo "<td class=lineh align=center width=188 height=245>";
echo "<table border=0 cellpadding=0 cellspacing=0>";
echo "<tr><td height=100 class=t10b valign=top align=center>И з в е щ е н и е</td></tr>";
echo "<tr><td height=100 class=t10b valign=bottom align=center>Кассир</td></tr>";
echo "</table>";
echo "</td>";
echo "<td width=16 class=linevh height=245>&nbsp;</td>";
echo "<td class=lineh height=245>";
echo "<table width=477 border=0 cellpadding=0 cellspacing=0 align=center style='height: 245px'>";
echo "<tr>";
echo "<td height=40>";
echo "<table width='100%' align=center cellspacing=0 border=0 cellpadding=0>";
echo "<tr>";
echo "<td><img src='/img/sblogo.gif' width=120 height=26 alt='Sberbank logo'></td>";
echo "<td class=t6n align=right valign=middle><i>Форма № ПД-4</i></td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td class=h8b valign=bottom align=center>".$this->firm."</td>";
echo "</tr>";
echo "<tr>";
echo "<td height=10 class=t6n valign=top align=center>(наименование получателя платежа)</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 width='100%' cellpadding=0>";
echo "<tr>";
echo "<td width='30%' valign=bottom><table class=line_r border=0 cellspacing=0 width='100%' cellpadding=0><tr>";
if (strlen($this->innpol)> 10):
  $cel_size = '8%';
else:
  $cel_size = '10%';
endif;
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[0]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[1]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[2]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[3]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[4]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[5]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[6]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[7]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[8]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[9]."</td>";
if (strlen($this->innpol)> 10):
  echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[10]."</td>";
  echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[11]."</td>";
endif;
echo "</tr></table></td><td width='10%' valign=bottom>&nbsp;</td>";
echo "<td width='60%' valign=bottom>";

echo "<table class=line_r border=0 cellspacing=0 cellpadding=0 width='100%'><tr>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[0]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[1]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[2]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[3]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[4]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[5]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[6]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[7]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[8]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[9]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[10]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[11]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[12]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[13]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[14]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[15]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[16]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[17]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[18]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[19]."</td></tr></table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td valign=top class=t6n align=center>(ИНН получателя платежа)</td>";
echo "<td valign=top class=t6n>&nbsp;</td>";
echo "<td valign=top class=t6n align=center>(номер счета получателя платежа)</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 cellpadding=0 width='100%'>";
echo "<tr>";
echo "<td width=10 class=t8n valign=bottom>в</td>";
echo "<td class=h8b align=center valign=bottom>".$this->bank."</td>";
echo "<td width=40 class=t8n align=right valign=bottom>БИК&nbsp;</td>";
echo "<td width='27%' valign=bottom>";
echo "<table class=line_r border=0 cellspacing=0 width='100%' cellpadding=0><tr>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[0]."</td>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[1]."</td>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[2]."</td>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[3]."</td>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[4]."</td>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[5]."</td>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[6]."</td>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[7]."</td>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[8]."</td>";
echo "</tr></table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>&nbsp;</td>";
echo "<td valign=top class=t6n align=center>(наименование банка получателя платежа)</td>";
echo "<td>&nbsp;</td>";
echo "<td>&nbsp;</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 cellpadding=0 width='100%'>";
echo "<tr>";
echo "<td class=t7n valign=bottom>Номер&nbsp;кор./сч.&nbsp;банка&nbsp;получателя&nbsp;платежа</td>";
echo "<td width='60%' valign=bottom>";
echo "<table class=line_r border=0 cellspacing=0 cellpadding=0 width='100%'><tr>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[0]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[1]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[2]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[3]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[4]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[5]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[6]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[7]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[8]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[9]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[10]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[11]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[12]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[13]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[14]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[15]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[16]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[17]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[18]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[19]."</td></tr></table>";
echo "</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 cellpadding=0 width='100%'>";
echo "<tr>";
echo "<td class=h8b valign=bottom width='55%'>".$this->nazn."</td>";
echo "<td width='5%'>&nbsp;</td>";
echo "<td class=h8b valign=bottom>".$this->kodplat."</td>";
echo "</tr>";
echo "<tr>";
echo "<td valign=top class=t6n align=center>(наименование платежа)</td>";
echo "<td>&nbsp;</td>";
echo "<td valign=top class=t6n align=center>(номер лицевого счета (код) плательщика)</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 cellpadding=0 width='100%'>";
echo "<tr>";
echo "<td class=t8n valign=bottom width='1%'>Ф.И.О&nbsp;плательщика&nbsp;</td>";
echo "<td class=h8b valign=bottom>".$this->fio."</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 cellpadding=0 width='100%'>";
echo "<tr>";
echo "<td class=t8n valign=bottom width='1%'>Адрес&nbsp;плательщика&nbsp;</td>";
echo "<td class=h8b valign=bottom>".$this->address."</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 cellpadding=0 width='100%'>";
echo "<tr>";
echo "<td class=t8n valign=bottom width='1%'>Сумма&nbsp;платежа&nbsp;</td>";
 $sum = explode(".", $this->summ);
 $usl = explode(".", $this->uslug);
echo "<td class=h8b valign=bottom width='8%'>".$sum[0]."</td>";
echo "<td class=t8n valign=bottom width='1%'>&nbsp;руб.&nbsp;</td>";
echo "<td class=h8b valign=bottom width='8%'>".$sum[1]."</td>";

echo "<td class=t8n valign=bottom width='1%'>&nbsp;коп.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Сумма&nbsp;платы&nbsp;за&nbsp;услуги&nbsp;</td>";
echo "<td class=h8b valign=bottom width='8%'>".$usl[0]."</td>";
echo "<td class=t8n valign=bottom width='1%'>&nbsp;руб.&nbsp;</td>";
echo "<td class=h8b valign=bottom width='8%'>".$usl[1]."</td>";
echo "<td class=t8n valign=bottom width='1%'>&nbsp;коп.</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 cellpadding=0 width='100%'>";
echo "<tr>";
echo "<td class=t8n valign=bottom width='5%'>Итого&nbsp;</td>";
 $sum = explode(".", $this->summ);
 $usl = explode(".", $this->uslug);
 $dat = explode(".", $this->date);
$r =(int)($sum[0]+$usl[0]);
$k =(int)($sum[1]+$usl[1]);
if($k>=100){$r++;$k = (int)($sum[1]+$usl[1])-100;}
echo "<td class=h8b valign=bottom width='8%'>".$r."</td>";
echo "<td class=t8n valign=bottom width='5%'>&nbsp;руб.&nbsp;</td>";
echo "<td class=h8b valign=bottom width='8%'>".$k."</td>";
echo "<td class=t8n valign=bottom width='5%'>&nbsp;коп.&nbsp;</td>";
echo "<td class=t8n valign=bottom width='20%' align=right>&nbsp;'&nbsp;</td>";
echo "<td class=h8b valign=bottom width='8%'>".$dat[0]."</td>";
echo "<td class=t8n valign=bottom width='1%'>&nbsp;'&nbsp;</td>";
echo "<td class=h8b valign=bottom width='20%'>&nbsp;".$this->formatdate()."&nbsp;</td>";
echo "<td class=t8n valign=bottom width='4%'>&nbsp;20&nbsp;</td>";
echo "<td class=h8b valign=bottom width='3%'>".$dat[2]."</td>";
echo "<td class=t8n valign=bottom width='1%'>&nbsp;г.</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td class=t7n valign=bottom style='text-align: justify'>С условиями приема указанной в платежном документе суммы, в т.ч. с суммой взимаемой платы за&nbsp;услуги банка,&nbsp;ознакомлен&nbsp;и&nbsp;согласен.</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 cellpadding=0 width='100%'>";
echo "<tr>";
echo "<td class=t6n valign=bottom width='50%'>&nbsp;</td>";
echo "<td class=t7n valign=bottom width='1%'><b>Подпись&nbsp;плательщика&nbsp;</b></td>";
echo "<td class=h8b valign=bottom width='40%'>&nbsp;</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr><td height=1 class=spc>&nbsp;</td></tr>";
echo "</table>";
echo "</td>";
echo "<td width=16 class=lineh height=245>&nbsp;</td>";
echo "</tr>";
echo "<tr>";
echo "<td height=285 class=t10b valign=bottom width=188 align=center>Квитанция<br><br>Кассир<br>&nbsp;</td>";
echo "<td height=285 width=16 class=linev>&nbsp;</td>";
echo "<td height=285 valign=top> ";
echo "<table width=477 border=0 cellpadding=0 cellspacing=0 align=center style='height: 285px'>";
echo "<tr>";
echo "<td height=30 class=h8b valign=bottom align=center>".$this->firm."</td>";
echo "</tr>";
echo "<tr> ";
echo "<td height=10 class=t6n valign=top align=center>(наименование получателя платежа)</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 width='100%' cellpadding=0>";
echo "<tr>";
echo "<td width='30%' valign=bottom><table class=line_r border=0 cellspacing=0 width='100%' cellpadding=0><tr>";
if (strlen($this->innpol)> 10):
  $cel_size = '8%';
else:
  $cel_size = '10%';
endif;
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[0]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[1]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[2]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[3]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[4]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[5]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[6]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[7]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[8]."</td>";
echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[9]."</td>";
if (strlen($this->innpol)> 10):
  echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[10]."</td>";
  echo "<td height=10 class=line_lbt width='$cel_size' align=center>".$this->innpol[11]."</td>";
endif;
echo "</tr></table></td><td width='10%' valign=bottom>&nbsp;</td>		<td width='60%' valign=bottom>";

echo "<table class=line_r border=0 cellspacing=0 cellpadding=0 width='100%'><tr>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[0]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[1]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[2]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[3]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[4]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[5]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[6]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[7]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[8]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[9]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[10]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[11]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[12]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[13]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[14]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[15]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[16]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[17]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[18]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->nsch[19]."</td></tr></table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td valign=top class=t6n align=center>(ИНН получателя платежа)</td>";
echo "<td valign=top class=t6n>&nbsp;</td>";
echo "<td valign=top class=t6n align=center>(номер счета получателя платежа)</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 cellpadding=0 width='100%'>";
echo "<tr>";
echo "<td width=10 class=t8n valign=bottom>в</td>";
echo "<td class=h8b align=center valign=bottom>".$this->bank."</td>";
echo "<td width=40 class=t8n align=right valign=bottom>БИК&nbsp;</td>";
echo "<td width='27%' valign=bottom>";
echo "<table class=line_r border=0 cellspacing=0 width='100%' cellpadding=0><tr>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[0]."</td>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[1]."</td>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[2]."</td>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[3]."</td>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[4]."</td>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[5]."</td>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[6]."</td>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[7]."</td>";
echo "<td height=10 class=line_lbt width='10%' align=center>".$this->bik[8]."</td>";
echo "</tr></table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>&nbsp;</td>";
echo "<td valign=top class=t6n align=center>(наименование банка получателя платежа)</td>";
echo "<td>&nbsp;</td>";
echo "<td>&nbsp;</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 cellpadding=0 width='100%'>";
echo "<tr>";
echo "<td class=t7n valign=bottom>Номер&nbsp;кор./сч.&nbsp;банка&nbsp;получателя&nbsp;платежа</td>";
echo "<td width='60%' valign=bottom>";
echo "<table class=line_r border=0 cellspacing=0 cellpadding=0 width='100%'><tr>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[0]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[1]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[2]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[3]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[4]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[5]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[6]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[7]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[8]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[9]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[10]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[11]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[12]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[13]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[14]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[15]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[16]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[17]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[18]."</td>";
echo "<td height=10 class=line_lbt width='5%' align=center>".$this->korsch[19]."</td></tr></table>";
echo "</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 cellpadding=0 width='100%'>";
echo "<tr>";
echo "<td class=h8b valign=bottom width='55%'>".$this->nazn."</td>";
echo "<td width='5%'>&nbsp;</td>";
echo "<td class=h8b valign=bottom>".$this->kodplat."</td>";
echo "</tr>";
echo "<tr>";
echo "<td valign=top class=t6n align=center>(наименование платежа)</td>";
echo "<td>&nbsp;</td>";
echo "<td valign=top class=t6n align=center>(номер лицевого счета (код) плательщика)</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 cellpadding=0 width='100%'>";
echo "<tr>";
echo "<td class=t8n valign=bottom width='1%'>Ф.И.О&nbsp;плательщика&nbsp;</td>";
echo "<td class=h8b valign=bottom>".$this->fio."</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 cellpadding=0 width='100%'>";
echo "<tr>";
echo "<td class=t8n valign=bottom width='1%'>Адрес&nbsp;плательщика&nbsp;</td>";
echo "<td class=h8b valign=bottom>".$this->address."</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 cellpadding=0 width='100%'>";
echo "<tr>";
echo "<td class=t8n valign=bottom width='1%'>Сумма&nbsp;платежа&nbsp;</td>";
 $sum = explode(".", $this->summ);
 $usl = explode(".", $this->uslug);
echo "<td class=h8b valign=bottom width='8%'>".$sum[0]."</td>";
echo "<td class=t8n valign=bottom width='1%'>&nbsp;руб.&nbsp;</td>";
echo "<td class=h8b valign=bottom width='8%'>".$sum[1]."</td>";
echo "<td class=t8n valign=bottom width='1%'>&nbsp;коп.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Сумма&nbsp;платы&nbsp;за&nbsp;услуги&nbsp;</td>";
echo "<td class=h8b valign=bottom width='8%'>".$usl[0]."</td>";
echo "<td class=t8n valign=bottom width='1%'>&nbsp;руб.&nbsp;</td>";
echo "<td class=h8b valign=bottom width='8%'>".$usl[1]."</td>";
echo "<td class=t8n valign=bottom width='1%'>&nbsp;коп.</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 cellpadding=0 width='100%'>";
echo "<tr>";
echo "<td class=t8n valign=bottom width='5%'>Итого&nbsp;</td>";
 $sum = explode(".", $this->summ);
 $usl = explode(".", $this->uslug);
 $dat = explode(".", $this->date);
$r =(int)($sum[0]+$usl[0]);
$k =(int)($sum[1]+$usl[1]);
if($k>=100){$r++;$k = (int)($sum[1]+$usl[1])-100;}
echo "<td class=h8b valign=bottom width='8%'>".$r."</td>";
echo "<td class=t8n valign=bottom width='5%'>&nbsp;руб.&nbsp;</td>";
echo "<td class=h8b valign=bottom width='8%'>".$k."</td>";
echo "<td class=t8n valign=bottom width='5%'>&nbsp;коп.&nbsp;</td>";
echo "<td class=t8n valign=bottom width='20%' align=right>&nbsp;'&nbsp;</td>";
echo "<td class=h8b valign=bottom width='8%'>".$dat[0]."</td>";
echo "<td class=t8n valign=bottom width='1%'>&nbsp;'&nbsp;</td>";
echo "<td class=h8b valign=bottom width='20%'>&nbsp;".$this->formatdate()."&nbsp;</td>";
echo "<td class=t8n valign=bottom width='4%'>&nbsp;20&nbsp;</td>";
echo "<td class=h8b valign=bottom width='3%'>".$dat[2]."</td>";
echo "<td class=t8n valign=bottom width='1%'>&nbsp;г.</td>";
echo "</tr>";
echo "</table>";

echo "</td>";
echo "</tr>";
echo "<tr>";
echo "<td class=t7n valign=bottom style='text-align: justify'>С условиями приема указанной в платежном документе суммы, в т.ч. с суммой взимаемой платы за&nbsp;услуги банка,&nbsp;ознакомлен&nbsp;и&nbsp;согласен.</td>";
echo "</tr>";
echo "<tr>";
echo "<td>";
echo "<table border=0 cellspacing=0 cellpadding=0 width='100%'>";
echo "<tr>";
echo "<td class=t6n valign=bottom width='50%'>&nbsp;</td>";
echo "<td class=t7n valign=bottom width='1%'><b>Подпись&nbsp;плательщика&nbsp;</b></td>";
echo "<td class=h8b valign=bottom width='40%'>&nbsp;</td>";
echo "</tr>";
echo "</table>";
echo "</td>";
echo "</tr>";
echo "<tr><td height=1 class=spc>&nbsp;</td></tr>";
echo "</table>";
echo "</td>";
echo "<td width=16>&nbsp;</td>";
echo "</tr>";
echo "</table>";
echo "</td></tr>";
echo "<tr><td>";
echo "</td></tr></table>";

echo "</body>";
echo "</html>";
} //print

function formatdate(){

$d = explode(".",$this->date);
if($d[1]=="01"){return "января";}
if($d[1]=="02"){return "февраля";}
if($d[1]=="03"){return "марта";}
if($d[1]=="04"){return "апреля";}
if($d[1]=="05"){return "мая";}
if($d[1]=="06"){return "июня";}
if($d[1]=="07"){return "июля";}
if($d[1]=="08"){return "августа";}
if($d[1]=="09"){return "сентября";}
if($d[1]=="10"){return "октября";}
if($d[1]=="11"){return "ноября";}
if($d[1]=="12"){return "декабря";}


}
};











?>