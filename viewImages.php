<?php include('./header.php');


$type = $_REQUEST['type'];

if(isset($type) && $type!=''){

    ?>


    <h1 class="h3 mb-4 text-gray-800"><?php echo ucwords($type) . ' Images' ; ?></h1>

<?php
    $sql = mysqli_query($con,"select * from classificationdetails where type='".$type."' order by id desc");

    ?>

<div class="row">
    <?php 
    while($sql_result = mysqli_fetch_assoc($sql)){


        $image_name = $sql_result['image_name'];
        ?>
            <div class="col-sm-3 mb-4">
            <a href="./cleanDetection/<?php echo $type; ?>/<?php echo $image_name ; ?>">
            <img src="./cleanDetection/<?php echo $type; ?>/<?php echo $image_name ; ?>" alt="" style="width: 200px;height: 200px;">
            </a>
            
            </div>

<?php


    }

    ?>

    </div>
    <?php


}else{
    echo 'Invalid Request !' ;
}



include('./footer.php');

?>