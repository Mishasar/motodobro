 <?php
$order_id=$_REQUEST['order_id'];


  $s = sql("SELECT concat(r.form, ' ', r.name) as firm, r.inn as innpol, r.rass as nsch, r.bank, r.bik,
                   r.kors as korsch, c.name as fio, c.adress as address, t.sum_order_rub as summ, 
                   DATE_FORMAT(CURRENT_DATE(), '%d.%m.%y') as dt, c.id as kodplat, t.num
            FROM trans t, myrec_rec r, client c WHERE r.id=t.face_rec_id AND c.id=t.client AND t.id=$order_id");

   $r = mysql_fetch_array($s);

$param = array(firm => trim($r['firm']), innpol => $r['innpol'], nsch => $r['nsch'],
               bank => $r['bank'], bik => $r['bik'], korsch => $r['korsch'],
               nazn => "Оплата за заказ № ".$r['num'], kodplat => $r['kodplat'], fio => $r['fio'],
               address => stripslashes($r['address']), summ => number_format($r['summ'], 2, '.', ''), uslug => "0.00", date => $r['dt']);
include('includes/formpd4.php');
$pd4 = new formpd4($param);
$pd4->printform();
echo '<SCRIPT LANGUAGE="JavaScript">
                print();
      </SCRIPT>';
 ?>