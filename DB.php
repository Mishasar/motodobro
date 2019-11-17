<?php

class DB {
    protected $db;
    
    function __construct()
    {
        // establish mySQLi connection
        //$this->db = new mysqli('95.183.13.61', 'motodobro_moto', 'GVMiKbQ3U5', 'motodobro_moto');
        $this->db = new mysqli('localhost', 'motodobro_moto', 'w09UwdgJQ6', 'motodobro_moto');
        $this->db->set_charset('utf8');
        if ($this->db->connect_errno) throw new Exception ('Could not connect: ' . $this->db->connect_error);
    }

    function __destruct() {
        $this->db->close();
    }

    protected function query($query)
    {
        $res = $this->db->query($query);
        if (!$res) throw new Exception ($this->db->error);
        return $res;
    }

    protected function multiQuery($query)
    {
        if ($this->db->multi_query($query))
        {
            $result = FALSE;
            do
            {
                $res = $this->db->use_result();
                if ($res) $result = $res;
            } while ($this->db->next_result());
            return $result;
        } else
            throw new Exception ($this->db->error);
    }

    protected function esc($text)
    {
        return $this->db->real_escape_string($text);
    }

    function getQuery($request)
    {
        return $this->query($request);
    }
    
    function getOEMVehicleItems(){
        $result = $this->query("SELECT id, name, prim FROM w_group ORDER BY ord");
        
        $items = array();
        while ($row = $result->fetch_assoc()) $items [] = $row;
        
        return $items;
    }
    
    function getOEMVehicleBrandsByItem($item){
        $_item = $this->esc($item);
        $result = $this->query("SELECT id, name FROM w_brand WHERE group_id=".$_item." ORDER BY name");
        
        $items = array();
        while ($row = $result->fetch_assoc()) $items [] = $row;
        
        return $items;
    }
    
    
    // monitior.php
    
    function getMonitorRecords($site){
        $request = $site == 'all' ? '' : " WHERE site='$site' ";
        $resTemp=$this->query ("SELECT detail_code, brand_name, time ,site, text, created FROM log ORDER BY id DESC limit 20");
        $res = [];
        while ($row = $resTemp->fetch_object()) $res[]=$row;
        return $res;
    }
    
    function getLastDetailCheckDateTimeImpex(){
        //$resTemp=$this->query("SELECT last_check_time FROM check_details WHERE type='boats' ");
        $resTemp=$this->query("SELECT value FROM param WHERE type='last_date_time_check_impex' ");
        $row = $resTemp->fetch_object();
        return $row->value;
    }
    
    function getLastDetailCheckDateTimeBoats(){
        $resTemp=$this->query("SELECT value FROM param WHERE type='last_date_time_check_boats' ");
        $row = $resTemp->fetch_object();
        return $row->value;
    }
    
    function getLastDetailCheckDateTimeBoardtracker(){
        $resTemp=$this->query("SELECT value FROM param WHERE type='last_date_time_check_boardtracker' ");
        $row = $resTemp->fetch_object();
        return $row->value;
    }
    
    function getLastDetailCheckDateTimeOem($param){
        $p = 'last_date_time_check_oem_throw_'.$param;
        
        $resTemp=$this->query("SELECT value FROM param WHERE type='$p' ");
        if($row = $resTemp->fetch_object()){
            return $row->value;
        }
        else{
            return '';
        }
    }
            
    function getCountHandledDetails(){
        $resTemp=$this->query ("SELECT (SELECT COUNT(*) FROM detail_code WHERE check_impex_date IS NOT NULL) as count_impex, COUNT(*) as count, (SELECT COUNT(*) FROM detail_code) as impex_all, (SELECT COUNT(*) FROM detail_code_boats) as boats_all, (SELECT COUNT(*) FROM detail_code_boats WHERE check_boats_date IS NOT NULL) as count_boats FROM detail_code");
        $row = $resTemp->fetch_object();
        return $row;
    }
    
    function getCountHandledBoardtrackerDetailsAll(){
        $resTemp=$this->query ("SELECT COUNT(*) as count FROM detail_code_boardtracker");
        $row = $resTemp->fetch_object();
        return $row;
    }
    
    function getCountHandledBoardtrackerDetailsRemain(){
        $resTemp=$this->query ("SELECT COUNT(*) as count FROM detail_code_boardtracker WHERE checked IS NOT NULL");
        $row = $resTemp->fetch_object();
        return $row;
    }
            
    function cleanLog(){
        //$this->query("DELETE FROM log WHERE")
        
    }
    
    function getCountTriesToGetContentFrom($site){
        $field = $site == 'impex' ? " type='count_tries_impex' " : " type='count_tries_boats' " ; 
        $resTemp=$this->query ("SELECT value FROM param WHERE $field");
        $row = $resTemp->fetch_object();
        return $row->value;
    }
    
    function getUsedProxies(){
        $resTemp=$this->query ("SELECT value, type FROM param WHERE type LIKE 'ip-%'");
        $proxies = array();
        while($row = $resTemp->fetch_object()) {
            $proxies[] = $row;
        }
        
        return count($proxies) > 0 ? $proxies : null;
    }
    
    function getUsedProxiesImpex(){
        $resTemp=$this->query ("SELECT value, type FROM param WHERE type LIKE 'ip_impex-%'");
        $proxies = array();
        while($row = $resTemp->fetch_object()) {
            $proxies[] = $row;
        }
        
        return count($proxies) > 0 ? $proxies : null;
    }
    
    function getCurrentIpsNumber(){
        $resTemp=$this->query ("SELECT value FROM param WHERE type ='current_ips_number'");
        $row = $resTemp->fetch_object();
        
        return $row->value;
    }
    
    function getCurrentIpsNumberImpex(){
        $resTemp=$this->query ("SELECT value FROM param WHERE type ='current_ips_number_impex'");
        $row = $resTemp->fetch_object();
        
        return $row->value;
    }
            
    function getCountPositiveRequestsToBoats(){
        $res=$this->query ("SELECT COUNT(*) as count FROM param WHERE type ='general_time_boats'");
        $row = $res->fetch_object();
        
        return $row ? (int)$row->count : 0;
    }
    
    function getAverageValueBoatsTime(){
        $count = $this->getCountPositiveRequestsToBoats();
        $res=$this->query ("SELECT SUM(value) as sum FROM param WHERE type ='general_time_boats'");
        $row = $res->fetch_object();
        
        return $count > 0 && $row->sum ? ($row->sum / $count) : 0;
    }
    
    function getCurrentProxyBoats(){
        $res=$this->query ("SELECT value FROM param WHERE type ='current_proxy_boats'");
        $row = $res->fetch_object();
        return $row->value;
    }
    
    function getCurrentProxyImpex(){
        $res=$this->query ("SELECT value FROM param WHERE type ='current_proxy_impex'");
        $row = $res->fetch_object();
        return $row->value;
    }
    
    function getСountNegativeRequestsToBoats(){
        $res=$this->query ("SELECT SUM(value) as sum FROM param WHERE type LIKE 'ip-%' ");
        $row = $res->fetch_object();
        return $row->sum;
    }
    
    function getCountNegativeRequestsToImpex(){
        $res=$this->query ("SELECT SUM(value) as sum FROM param WHERE type LIKE 'ip_impex-%' ");
        $row = $res->fetch_object();
        return $row->sum;
    }
    
    function getCountPausedRequestsToBoats(){
        $res=$this->query ("SELECT COUNT(*) as count FROM detail_code_boats WHERE paused=1 ");
        $row = $res->fetch_object();
        return $row->count;
    }
    
    function getCountHandledItemsFromTable($table){
        $t = 'oem_'.$table;
        $res=$this->query ("SELECT COUNT(*) as count FROM $t WHERE checked=1  OR paused=1");
        if($row = $res->fetch_object()){
            return $row->count;
        }
        else{
            return 0;
        }        
    }
    
    function getCountHandledUnits(){       
        $res1=$this->query ("SELECT COUNT(*) as count FROM oem_unit_1 WHERE checked=1");
        $res2=$this->query ("SELECT COUNT(*) as count FROM oem_unit_2 WHERE checked=1");
        $res3=$this->query ("SELECT COUNT(*) as count FROM oem_unit_3 WHERE checked=1");
        $res4=$this->query ("SELECT COUNT(*) as count FROM oem_unit_4 WHERE checked=1");
        
        if($row1 = $res1->fetch_object()){
            $r1 = $row1->count;
        }
        else{
            $r1 = 0;
        } 
        
        if($row2 = $res2->fetch_object()){
            $r2 = $row2->count;
        }
        else{
            $r2 = 0;
        } 
        
        if($row3 = $res3->fetch_object()){
            $r3 = $row3->count;
        }
        else{
            $r3 = 0;
        } 
        
        if($row4 = $res4->fetch_object()){
            $r4 = $row4->count;
        }
        else{
            $r4 = 0;
        } 
        
        return $r1 + $r2 + $r3 +$r4;
    }

    function getCountPausedModels(){
        $res1=$this->query ("SELECT COUNT(*) as count FROM oem_model WHERE paused=1");

        if($row1 = $res1->fetch_object()){
            $r1 = $row1->count;
        }
        else{
            $r1 = 0;
        }

        return $r1;
    }

    function getCountPausedUnits(){       
        $res1=$this->query ("SELECT COUNT(*) as count FROM oem_unit_1 WHERE paused=1");
        $res2=$this->query ("SELECT COUNT(*) as count FROM oem_unit_2 WHERE paused=1");
        $res3=$this->query ("SELECT COUNT(*) as count FROM oem_unit_3 WHERE paused=1");
        $res4=$this->query ("SELECT COUNT(*) as count FROM oem_unit_4 WHERE paused=1");
        
        if($row1 = $res1->fetch_object()){
            $r1 = $row1->count;
        }
        else{
            $r1 = 0;
        } 
        
        if($row2 = $res2->fetch_object()){
            $r2 = $row2->count;
        }
        else{
            $r2 = 0;
        } 
        
        if($row3 = $res3->fetch_object()){
            $r3 = $row3->count;
        }
        else{
            $r3 = 0;
        } 
        
        if($row4 = $res4->fetch_object()){
            $r4 = $row4->count;
        }
        else{
            $r4 = 0;
        } 
        
        return $r1 + $r2 + $r3 +$r4;
    }
    
    function getCountItemsFromTable($table){
        $t = 'oem_'.$table;
        
        $res=$this->query ("SELECT COUNT(*) as count FROM $t ");
        if($row = $res->fetch_object()){
            return $row->count;
        }
        else{
            return 0;
        } 
    }

    function getCountProxy(){
        $res=$this->query ("SELECT COUNT(*) as count FROM proxy_ip ");
        if($row = $res->fetch_object()){
            return $row->count;
        }
        else{
            return 0;
        }
    }

    function getCountActiveProxy(){
        $res=$this->query ("SELECT COUNT(*) as count FROM proxy_ip WHERE is_active=1");
        if($row = $res->fetch_object()){
            return $row->count;
        }
        else{
            return 0;
        }
    }

    function getCountUnActiveProxy(){
        $res=$this->query ("SELECT COUNT(*) as count FROM proxy_ip WHERE is_active=0");
        if($row = $res->fetch_object()){
            return $row->count;
        }
        else{
            return 0;
        }
    }

    function getСountBannedProxy(){
        $res=$this->query ("SELECT COUNT(*) as count FROM proxy_ip WHERE is_banned=1");
        if($row = $res->fetch_object()){
            return $row->count;
        }
        else{
            return 0;
        }
    }

    function getCountBadProxy(){
        $res=$this->query ("SELECT COUNT(*) as count FROM proxy_ip WHERE is_bad=1");
        if($row = $res->fetch_object()){
            return $row->count;
        }
        else{
            return 0;
        }
    }
}
