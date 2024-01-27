<?php 
if (!isset($_SESSION)) {
    session_start();
}
if (!isset($_SESSION['nip'])) {
    header("Location: index.php?page=loginDokter");
    exit;
}

    if (isset($_POST['simpanData'])) {
        $id_dokter = $_SESSION['id'];
        $hari = $_POST['hari'];
        $jam_mulai = $_POST['jam_mulai'];
        $jam_selesai = $_POST['jam_selesai'];
        $aktif = $_POST['aktif'];
    
        // If the new status is 'Active', set all other statuses to 'Inactive'
        if ($aktif == "Y") {
            $stmt = $mysqli->prepare("UPDATE jadwal_periksa SET aktif='T' WHERE id_dokter=?");
            $stmt->bind_param("i", $id_dokter);
            $stmt->execute();
            $stmt->close();
        }
    
        if (isset($_POST['id'])) {
            $id = $_POST['id'];
            $stmt = $mysqli->prepare("UPDATE jadwal_periksa SET id_dokter=?, hari=?, jam_mulai=?, jam_selesai=?, aktif=? WHERE id=?");
            $stmt->bind_param("issssi", $id_dokter, $hari, $jam_mulai, $jam_selesai, $aktif,  $id);
    
            if ($stmt->execute()) {
                echo "
                    <script> 
                        alert('Berhasil mengubah data.');
                        document.location='berandaDokter.php?page=aturJadwalDokter';
                    </script>
                ";
            } else {
                // Handle error
            }
    
            $stmt->close();
        } else {
            $stmt = $mysqli->prepare("INSERT INTO jadwal_periksa (id_dokter, hari, jam_mulai, jam_selesai, aktif) VALUES (?, ?, ?, ?, ?)");
            $stmt->bind_param("isssi", $id_dokter, $hari, $jam_mulai, $jam_selesai, $aktif);
    
            if ($stmt->execute()) {
                echo "
                    <script> 
                        alert('Berhasil menambah data.');
                        document.location='berandaDokter.php?page=aturJadwalDokter';
                    </script>
                ";
            } else {
                // Handle error
            }
    
            $stmt->close();
        }
    }

    if (isset($_GET['aksi'])) {
        if ($_GET['aksi'] == 'hapus') {
            $stmt = $mysqli->prepare("DELETE FROM jadwal_periksa WHERE id = ?");
            $stmt->bind_param("i", $_GET['id']);

            if ($stmt->execute()) {
                echo "
                    <script> 
                        alert('Berhasil menghapus data.');
                        document.location='berandaDokter.php?page=aturJadwalDokter';
                    </script>
                ";
            } else {
                echo "
                    <script> 
                        alert('Gagal menghapus data: " . mysqli_error($mysqli) . "');
                        document.location='berandaDokter.php?page=aturJadwalDokter';
                    </script>
                ";
            }

            $stmt->close();
        }
    }
?>

<main id="aturJadwalDokter-page">
    <div class="container" style="margin-top: 5.5rem;">
        <div class="row">
            <h2 class="ps-0">Jadwal Dokter</h2>
            <div class="container">
                <form action="" method="POST" onsubmit="return(validate());">
                    <?php
                    $id_dokter = '';
                    $hari = '';
                    $jam_mulai = '';
                    $jam_selesai = '';
                    $aktif = '';
                    if (isset($_GET['id'])) {
                        $get = mysqli_query($mysqli, "SELECT * FROM jadwal_periksa 
                                WHERE id='" . $_GET['id'] . "'");
                        while ($row = mysqli_fetch_array($get)) {
                            $id_dokter = $row['id_dokter'];
                            $hari = $row['hari'];
                            $jam_mulai = $row['jam_mulai'];
                            $jam_selesai = $row['jam_selesai'];
                            $aktif = $row['aktif'];
                        }
                    ?>
                        <input type="hidden" name="id" value="<?php echo $_GET['id'] ?>">
                    <?php
                    }
                    ?>
                    <div class="dropdown mb-3 w-25">
                        <label for="id_dokter">Dokter <span class="text-danger">*</span></label>
                        <select disabled class="form-select" name="id_dokter" aria-label="id_dokter">
                            <option value="" selected>Pilih Dokter...</option>
                            <?php
                                $id_dokter = $_SESSION['id'];

                                $result = mysqli_query($mysqli, "SELECT * FROM dokter WHERE id");

                                while($data = mysqli_fetch_assoc($result)) {
                                    $selected = ($data['id'] == $id_dokter) ? 'selected' : ''; // If the doctor id matches the session id, mark it as selected
                                    echo "<option $selected value='" . $data['id'] . "'>" . $data['nama'] . "</option>";
                                }
                            ?>
                        </select>
                    </div>
                    <div class="dropdown mb-3 w-25">
                        <label for="hari">Hari <span class="text-danger">*</span></label>
                        <select class="form-select" name="hari" aria-label="hari" disabled>
                            <option value="" selected>Pilih Hari...</option>
                            <?php
                                $days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
                                foreach ($days as $day) {
                                    $selected = ($day == $hari) ? 'selected' : '';
                                    echo "<option value='$day' $selected>$day</option>";
                                }
                            ?>
                        </select>
                        <!-- Hidden input to send the value -->
                        <input type="hidden" name="hari" value="<?php echo $hari ?>">
                    </div>
                    <div class="mb-3 w-25">
                        <label for="jam_mulai">Jam Mulai <span class="text-danger">*</span></label>
                        <input disabled type="time" name="jam_mulai" class="form-control" required value="<?php echo $jam_mulai ?>">
                        <input type="hidden" name="jam_mulai" value="<?php echo $jam_mulai ?>">
                    </div>
                    <div class="mb-3 w-25">
                        <label for="jam_selesai">Jam Selesai <span class="text-danger">*</span></label>
                        <input disabled type="time" name="jam_selesai" class="form-control" required value="<?php echo $jam_selesai ?>">
                        <input type="hidden" name="jam_selesai" value="<?php echo $jam_selesai ?>">
                    </div>
                    <div class="dropdown mb-3 w-25">
                        <label for="aktif">Status <span class="text-danger">*</span></label>
                        <select class="form-select" name="aktif" aria-label="aktif">
                            <option value="" selected>Pilih Status...</option>
                            <?php
                                $statuses = ['Y' => 'Active', 'T' => 'Inactive'];
                                foreach ($statuses as $status => $statusName) {
                                    $selected = ($status == $aktif) ? 'selected' : '';
                                    echo "<option value='$status' $selected>$statusName</option>";
                                }
                            ?>
                        </select>
                    </div>
                    <div class="d-flex justify-content-end mt-2">
                        <button type="submit" name="simpanData" class="btn btn-primary">Simpan</button>
                    </div>
    
                </form>
                <script>
                    function checkForm() {
                        var id_dokter = document.querySelector('select[name="id_dokter"]').value;
                        var hari = document.querySelector('select[name="hari"]').value;
                        var jam_mulai = document.querySelector('input[name="jam_mulai"]').value;
                        var jam_selesai = document.querySelector('input[name="jam_selesai"]').value;
                        var aktif = document.querySelector('select[name="aktif"]').value;

                        if(id_dokter == "" || hari == "" || jam_mulai == "" || jam_selesai == "" || aktif == "") {
                            document.querySelector('button[name="simpanData"]').disabled = true;
                        } else {
                            document.querySelector('button[name="simpanData"]').disabled = false;
                        }
                    }

                    // Call checkForm function every time form inputs change
                    document.querySelector('form').addEventListener('change', checkForm);

                    // Call checkForm function on page load to ensure button is in correct state
                    window.onload = checkForm;
                </script>
            </div>

            <div class="table-responsive mt-3 px-0">
                <table class="table text-center">
                    <thead class="table-primary">
                        <tr>
                            <th valign="middle">No</th>
                            <th valign="middle">Nama Dokter</th>
                            <th valign="middle">Hari</th>
                            <th valign="middle" style="width: 25%;" colspan="2">Waktu</th>
                            <!-- <th valign="middle">Jam Selesai</th> -->
                            <th valign="middle">Status</th>
                            <th valign="middle" style="width: 0.5%;" colspan="2">Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                            $id_dokter = $_SESSION['id'];

                            $result = mysqli_query($mysqli, "SELECT dokter.nama, jadwal_periksa.id, jadwal_periksa.hari, jadwal_periksa.jam_mulai, jadwal_periksa.jam_selesai, jadwal_periksa.aktif 
                            FROM dokter 
                            JOIN jadwal_periksa ON dokter.id = jadwal_periksa.id_dokter 
                            WHERE dokter.id = $id_dokter");
                            $no = 1;
                            $data = mysqli_fetch_all($result, MYSQLI_ASSOC);
                            $rowspan = count($data);
                            foreach ($data as $index => $row) :
                        ?>
                            <tr>
                                <?php if ($index === 0): ?>
                                <td rowspan="<?php echo $rowspan; ?>" style="vertical-align: middle;">
                                    <div style="display: flex; align-items: center; justify-content: center; height: 100%;">
                                        <?php echo $no++ ?>
                                    </div>
                                </td>
                                <td rowspan="<?php echo $rowspan; ?>" style="vertical-align: middle;">
                                    <div style="display: flex; align-items: center; justify-content: center; height: 100%;">
                                        <?php echo $row['nama'] ?>
                                    </div>
                                </td>
                                <?php endif; ?>
                                <td><?php echo $row['hari'] ?></td>
                                <td><?php echo $row['jam_mulai'] ?> WIB</td>
                                <td><?php echo $row['jam_selesai'] ?> WIB</td>
                                <td>
                                    <?php 
                                        echo ($row['aktif'] == "Y") 
                                            ? '<p class="bg-success text-white border rounded p-1 mb-0">Active</p>' 
                                            : '<p class="bg-danger text-white border rounded p-1 mb-0">Inactive</p>'; 
                                    ?>
                                </td>
                                <td>
                                    <a class="btn btn-sm btn-warning text-white" href="berandaDokter.php?page=aturJadwalDokter&id=<?php echo $row['id'] ?>">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                </td>
                                <td>
                                    <a href="berandaDokter.php?page=aturJadwalDokter&id=<?php echo $row['id'] ?>&aksi=hapus" class="btn btn-sm btn-danger text-white">
                                        <i class="fa-solid fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>