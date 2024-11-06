<?php include('./header.php') ;

$id = $_REQUEST['id'];


$sql = mysqli_query($con,"select * from classification where id='".$id."'");
if($sql_result = mysqli_fetch_assoc($sql)){

    $details_sql = mysqli_query($con,"select type,count(1) as total from classificationdetails where classificationid='".$id."' group by type");
    while($details_sql_result = mysqli_fetch_assoc($details_sql)){

        $type = $details_sql_result['type'];
        $total = $details_sql_result['total'];

        echo ucwords($type) . ' : ' .$total . '<br />';

    }


}else{
    echo 'No Records Found ' ;
}




include('./footer.php');
?>