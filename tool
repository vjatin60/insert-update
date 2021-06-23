<?php
    include("db.php");
    $chake = $chakepassword = "";
    $edit = false;
    $id = "";
    $error = "";
    if(isset($_POST['submit']) == 'submit'){
        
          $adm_no = $_POST['adm_no'];
          $name = $_POST['name'];
          $fname = $_POST['fname'];
          $mname = $_POST['mname'];
          $pass_study = $_POST['pass_study'];
          
           $file = $_FILES['file']['name'];
       
            $dir = "pdf/";
            $starget_dir = $dir.basename($file);
            $imageFileType = strtolower(pathinfo($starget_dir,PATHINFO_EXTENSION));
       
            $stmp_name = $_FILES['file']['tmp_name'];
            move_uploaded_file($stmp_name, $starget_dir);
        
           
       
            $sql = "INSERT INTO `tc_detail`(`adm_no`, `name`, `fname`, `mname`, `pass_study`, `file`) VALUES ('$adm_no','$name','$fname','$mname','$pass_study','$file')";
            $query = mysqli_query($conn,$sql);
            if ($query) {
                header('Location: all-tc-detail.php');
            }else{
                $error = "Form not submit";
            }
        }
           
        
    
    if(isset($_GET['edit'])){
      $id = $_GET['edit'];
      $edit = true;
      $rec = mysqli_query($conn, "SELECT * FROM tc_detail where id =".$id);
      $row = mysqli_fetch_array($rec);
      $id = $row['id'];
      $adm_no = $row['adm_no'];
      $name = $row['name'];
      $fname = $row['fname'];
      $mname = $row['mname'];
    //   $name = $row['name'];
      $pass_study = $row['pass_study'];
      $file = $row['file'];
     
    }
    
    if(isset($_POST['update']) == "update"){
            $id = $_POST['id'];
           $adm_no = $_POST['adm_no'];
          $name = $_POST['name'];
          $fname = $_POST['fname'];
          $mname = $_POST['mname'];
          $pass_study = $_POST['pass_study'];
          
           
            
            $file = $_FILES['file']['name'];
             
            
                if($file == ""){ 
                $file = $row['file'];
                }
                $tmp_name   = $_FILES['file']['tmp_name'];
                $path = "pdf/$file";
                if(move_uploaded_file($tmp_name, $path)) {
                  copy($path, "$path");
                }
            
            
            
          
            $update = mysqli_query($conn, "UPDATE `tc_detail` SET `adm_no`='$adm_no',`name`='$name',`fname`='$fname',`mname`='$mname',`pass_study`='$pass_study',`file`='$file' WHERE id=$id");
            if($update){
                header("Location: all-tc-detail.php");
            }
        
    }
?>


 <input type="hidden" name="id" value="<?=$id?>">


   <td>
         <a href="delete.php?detail=1&id=<?=$row['id']?>" onclick="return confirm('Are you sure delete this record?')" class="btn btn-danger btn-xs" title="user-Delete">Delete</a>
         <a href="add-tc-detail.php?land=1&edit=<?=$row['id']?>" class="btn btn-primary btn-xs" title="Edit">Edit</a>
                                </td>
