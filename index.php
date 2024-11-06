<?php include ('./header.php');


$sql1 = mysqli_query($con, "select id as total from `classification`");

if (mysqli_fetch_assoc($sql1)) {
    $totalReportsRun = mysqli_fetch_assoc(mysqli_query($con, "select count(1) as total from `classification`"))['total'];
    $totalImagesScan = mysqli_fetch_assoc(mysqli_query($con, "select count(1) as total from `classificationdetails`"))['total'];


    $totalCleanImagesScan = mysqli_fetch_assoc(mysqli_query($con, "select count(1) as total from `classificationdetails` where type='clean'"))['total'];
    $totalUncleanImagesScan = mysqli_fetch_assoc(mysqli_query($con, "select count(1) as total from `classificationdetails` where type='unclean'"))['total'];
    $totalInvalidImagesScan = mysqli_fetch_assoc(mysqli_query($con, "select count(1) as total from `classificationdetails` where type='invalid'"))['total'];


} else {
    $totalReportsRun = 0;
    $totalImagesScan = 0;
    $totalCleanImagesScan = 0;
    $totalUncleanImagesScan = 0;
    $totalInvalidImagesScan = 0;

}





echo "<script>
        var cleanImages = $totalCleanImagesScan;
        var uncleanImages = $totalUncleanImagesScan;
        var invalidImages = $totalInvalidImagesScan;
      </script>";
?>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Get the canvas element
        var ctx = document.getElementById('donutChart').getContext('2d');

        // Create the data
        var data = {
            datasets: [{
                data: [cleanImages, uncleanImages, invalidImages],
                backgroundColor: [
                    'green', // clean
                    'orange', // unclean
                    'red' // invalid
                ]
            }],

            // These labels appear in the legend and in the tooltips when hovering different arcs
            labels: [
                'Clean Images',
                'Unclean Images',
                'Invalid Images'
            ]
        };

        // Create the donut chart
        var myDoughnutChart = new Chart(ctx, {
            type: 'doughnut',
            data: data,
        });
    });
</script>




<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
    <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
    <a href="./cleanDetection/classification_result.xlsx"
        class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" download>
        <i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
</div>

<!-- Content Row -->
<div class="row">

    <!-- Earnings (Monthly) Card Example -->
    <div class="col-xl-4 mb-4">
        <div class="card border-left-primary shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                            Total Reports Run</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><?= $totalReportsRun; ?></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Earnings (Monthly) Card Example -->
    <div class="col-xl-8 mb-4">
        <div class="card border-left-success shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                            Total Images Scan</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><?php echo $totalImagesScan; ?></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Earnings (Monthly) Card Example -->
    <div class="col-xl-4 mb-4">
        <div class="card border-left-info shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Clean
                        </div>
                        <div class="row no-gutters align-items-center">
                            <div class="col-auto">
                                <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
                                    <?php echo $totalCleanImagesScan; ?></div>
                            </div>
                            <div class="col">
                                <div class="progress progress-sm mr-2">
                                    <div class="progress-bar bg-info" role="progressbar" style="width: 50%"
                                        aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Pending Requests Card Example -->

    <div class="col-xl-4 mb-4">
        <div class="card border-left-warning shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                            Unclean</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><?php echo $totalUncleanImagesScan; ?>
                        </div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-comments fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <div class="col-xl-4 mb-4">
        <div class="card border-left-warning shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                            Invalid</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><?php echo $totalInvalidImagesScan; ?>
                        </div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-comments fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- Content Row -->

<div class="row">

    <!-- Area Chart -->
    <div class="col-xl-8 col-lg-7">
        <div class="card shadow mb-4">
            <!-- Card Header - Dropdown -->
            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                <h6 class="m-0 font-weight-bold text-primary">Latest Unclean Images</h6>
                <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                        <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                        aria-labelledby="dropdownMenuLink">
                        <div class="dropdown-header">Dropdown Header:</div>
                        <a class="dropdown-item" href="viewImages.php?type=unclean">View All</a>
                    </div>
                </div>
            </div>
            <!-- Card Body -->
            <div class="card-body">

                <div class="row">


                    <?php
                    $unclean_sql1 = mysqli_query($con, "select id from classificationdetails where type='unclean' order by id desc limit 12 ");
                    if (mysqli_fetch_assoc($unclean_sql1)) {

                        $unclean_sql = mysqli_query($con, "select * from classificationdetails where type='unclean' order by id desc limit 12 ");


                        while ($unclean_sql_result = mysqli_fetch_assoc($unclean_sql)) {

                            $image_name = $unclean_sql_result['image_name'];
                            ?>
                            <div class="col-sm-4 mb-4">
                                <a href="./cleanDetection/unclean/<?php echo $image_name; ?>">
                                    <img src="./cleanDetection/unclean/<?php echo $image_name; ?>" alt=""
                                        style="width: 200px;height: 200px;">
                                </a>

                            </div>
                        <?php }
                    } else {
                        echo 'No Unclean Images Found !';
                    } ?>

                </div>

            </div>
        </div>
    </div>

    <div class="col-xl-4 col-lg-5">
        <div class="card shadow mb-4">
            <!-- Card Header - Dropdown -->
            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                <h6 class="m-0 font-weight-bold text-primary">Category Wise</h6>
                <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                        <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                        aria-labelledby="dropdownMenuLink">
                        <div class="dropdown-header">Dropdown Header:</div>
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                </div>
            </div>

            <div class="card-body">
                <div class="chart-area">
                    <?php

                    if ($totalCleanImagesScan) {
                        ?>
                        <canvas id="donutChart" width="400" height="400"></canvas>
                    <?php } else {
                        echo 'No data Found ';
                    }

                    ?>
                </div>
            </div>

        </div>
    </div>
</div>


<?php include ('./footer.php'); ?>