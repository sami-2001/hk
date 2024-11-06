<!-- ---extra for chest door-- -->


<?php
if (isset($_POST['run_script'])) {
    // Execute the batch file
    // $output = shell_exec('C:\wamp64\www\houseKeeping\cleanDetection\run_test.bat');
    // echo "<pre>$output</pre>" ;

    $netstate_output = shell_exec('netstat -an | findstr :9000');

    if(isset($netstate_output) && $netstate_output != ''){
        ?>
        <style>
            #cleanDetectionPart {
                display: block !important;
            }

            iframe {
                width: 100%;
                height: 60vh;
            }

            #executionStartForm {
                display: none;
            }
        </style>
        <?php
    } else {
        ?>
        <style>
            #cleanDetectionPart {
                display: none;
            }
        </style>
        <?php
    }
}

// Handle stop script action
if (isset($_POST['stop_script'])) {
    $output = shell_exec('C:\wamp64\www\houseKeeping\cleanDetection\run_test_door.bat');
    echo "<pre>$output</pre>";

    $netstate_output = shell_exec('netstat -an | findstr :9000');

    if(isset($netstate_output) && $netstate_output != ''){
        ?>
        <style>
            #cleanDetectionPart {
                display: block !important;
            }

            iframe {
                width: 100%;
                height: 60vh;
            }

            #executionStartForm {
                display: none;
            }
        </style>
        <?php
    } else {
        ?>
        <style>
            #cleanDetectionPart {
                display: none;
            }
        </style>
        <?php
    }
}

// Handle refresh iframe action
if (isset($_POST['refresh_iframe'])) {
    // $output = shell_exec('C:\wamp64\www\houseKeeping\cleanDetection\run_test_shutter.bat');
    echo "<pre>$output</pre>";

    $netstate_output = shell_exec('netstat -an | findstr :9000');

    if(isset($netstate_output) && $netstate_output != ''){
        ?>
        <style>
            #cleanDetectionPart {
                display: block !important;
            }

            iframe {
                width: 100%;
                height: 60vh;
            }

            #executionStartForm {
                display: none;
            }
        </style>
        <?php
    } else {
        ?>
        <style>
            #cleanDetectionPart {
                display: none;
            }
        </style>
        <?php
    }
}
?>

<form method="post" id="executionStartForm">
    <button type="submit" class="btn btn-primary" name="run_script">Start Execution for Unclean Model</button>
    

</form>

<!-- Display cleanDetectionPart with iframe and buttons -->
<div id="cleanDetectionPart" style="display: none;">
    <iframe src="http://127.0.0.1:9000" frameborder="0"></iframe>
    <br><br>
    <form method="post">
        <button type="submit" class="btn btn-danger" name="stop_script">Stop Execution</button>
        <button type="submit" class="btn btn-primary" name="refresh_iframe">Refresh Iframe</button>
    </form>
</div>
