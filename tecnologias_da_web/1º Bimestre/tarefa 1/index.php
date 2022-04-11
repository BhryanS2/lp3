<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Index</title>
</head>

<body>
    <?php
    require './search.php';
    $numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    $search = new Search();
    $search->array = $numbers;
    $search->key = 5;
    $search->low = 0;
    $search->high = count($numbers) - 1;
    $search->mid = 0;
    // time
    $start = microtime(true);
    $result = $search->binarySearch($numbers, $search->key);
    $end = microtime(true);
    $time = $end - $start;
    echo '<p>Busca binária: ' . $result . ' no tempo de: ' . $time . '</p>';

    $start = microtime(true);
    $result = $search->linearSearch($numbers, $search->key);
    $end = microtime(true);
    $time = $end - $start;
    echo '<p>Busca linear: ' . $result . ' no tempo de: ' . $time . '</p>';

    $start = microtime(true);
    $result = $search->binarySearchRecursive($numbers, $search->key, $search->low, $search->high);
    $end = microtime(true);
    $time = $end - $start;
    echo '<p>Busca binária revursiva: ' . $result . ' no tempo de: ' . $time . '</p>';
    ?>
</body>

</html>