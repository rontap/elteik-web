<?php
    $data = [
        [
            "name" => "Kiss Jenő",
            "neptun" => "ABC123",
            "year" => 1996,
            "gender" => "férfi"
        ],
        [
            "name" => "Nagy Klára",
            "neptun" => "XYZ999",
            "year" => 1950,
            "gender" => "nő"
        ],
        [
            "name" => "Erős István",
            "neptun" => "IDDQD8",
            "year" => 1994,
            "gender" => "férfi"
        ]
    ];

    function getOldest($data){
        $min = reset($data);
        while ($tmp = next($data)){
            if ($tmp["year"] < $min["year"])
                $min = $tmp;
        }
        return $min["name"] . ($min["year"] < 1970 ? " (az egész életen át tartó tanulás példaképe)" : "");
    }

    function hasFemale($data){
        return in_array("nő", array_column($data, "gender"));
    }

    function genderCount($data, $g){
        return count(array_filter(array_column($data, "gender"), fn($x) => $x === $g));
    }
?>

<h1>Hallgatói nyilvántartás</h1>
<table>
    <tr>
        <th>Név</th>
        <th>Neptun</th>
        <th>Év</th>
        <th>Nem</th>
    </tr>
    <?php foreach($data as $stud): ?>
        <tr>
            <td> <?= $stud["name"] ?> </td>
            <td> <?= $stud["neptun"] ?> </td>
            <td> <?= $stud["year"] ?> </td>
            <td> <?= $stud["gender"] ?></td>
        </tr>
    <?php endforeach; ?>
</table>
Legidősebb hallgató: <?= getOldest($data) ?> <br>
Van-e lány? <?= hasFemale($data) ? "VAN! :)" : "Nincs. :C" ?>
<div style="background-color: blue; height: 20px; width: <?= genderCount($data, "férfi")*100 ?>px"></div>
<div style="background-color: pink; height: 20px; width: <?= genderCount($data, "nő")*100 ?>px"></div>
