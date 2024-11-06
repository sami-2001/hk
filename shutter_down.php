
<?php
include('./header.php');

if (isset($_POST['run_script'])) {
    // Execute the batch file
    // $output = shell_exec('CC:\wamp\www\housekeeping\cleanDetection\run_test.bat');
    // echo "<pre>$output</pre>";

    $netstate_output = shell_exec('netstat -an | findstr :9002') ;
    // echo "<pre>$netstate_output</pre>";

    if(isset($netstate_output) && $netstate_output != ''){
    
        ?>

<style>
    #cleanDetectionPart{
        display: block !important;
    }
    iframe{
        width: 100%;
    height: 60vh;
    }
    #executionStartForm{
        display:none;
    }
</style>
        <?php
    }else{
        ?>
        
<style>
 
    #cleanDetectionPart{
        display: none;
    }
</style>
        <?php
    }


}

?>



    <form method="post" id="executionStartForm">
        <button type="submit" class="btn btn-primary" name="run_script">Start shutterdown Execution</button>
    </form>




    <div id="cleanDetectionPart" style="display: none;">


    <iframe src="http://127.0.0.1:9002" frameborder="0"></iframe>


    </div>

    <?php 
    include('./footer.php');

?>