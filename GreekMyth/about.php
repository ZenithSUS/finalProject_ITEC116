<?php
  session_start();
  if(isset($_SESSION['user_id']) && isset($_COOKIE['user_id'])){
    echo "<script>window.location.href = 'index.php'</script>";
  }
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>About</title>
  <link rel="icon" href="new_logo.png">
  <link rel="stylesheet" href="styles/about.css">
  <link rel="icon" href="img/misc/logo_transparent.png">
</head>
<body>
  <div class="main-title">About the developers</div>
  <hr>

  <div class="container" onclick="showInfo('Jeran Christopher Merino', 'Main programmer specializing in backend systems and algorithms.' , 'Gen. Trias Cavite', 'December 25, 2002', 'https://www.facebook.com/jeranchristopher.merino')">
      <h3 class="title">Main Programmer</h3>
      <div class="content">
          <div class="content-overlay"></div>
          <img class="content-image" src="img/about/jeran.jpg" width="300" height="300">
          <div class="content-details fadeIn-bottom fadeIn-left">
            <h3>Jeran Christopher Merino</h3>
          </div>
      </div>
  </div>

  <div class="container" onclick="showInfo('Brian Millonte', 'Programmer with expertise in front-end development and UI/UX design.' , 'Gen. Trias Cavite', 'January 8, 2003','https://www.facebook.com/brian.millonte')">
    <h3 class="title">Programmer</h3>
    <div class="content">
        <div class="content-overlay"></div>
        <img class="content-image" src="img/about/brian.jpg" width="300" height="300">
        <div class="content-details fadeIn-bottom fadeIn-right">
          <h3>Brian Millonte</h3>
        </div>
     
    </div>
  </div>

  <div class="container" onclick="showInfo('Ij Marasigan', 'Team member focusing on documentation and testing.', 'Gen. Trias Cavite', 'November 8, 2003', 'https://www.facebook.com/isaacjames.marasigan.5')">
    <h3 class="title">Member</h3>
    <div class="content">

        <div class="content-overlay"></div>
        <img class="content-image" src="img/about/ij.jpg" width="300" height="300">
        <div class="content-details fadeIn-bottom fadeIn-left">
          <h3>Ij Marasigan</h3>
        </div>
     
    </div>
  </div>

  <div class="container" onclick="showInfo('Shawn Soriano', 'Team member focusing on documentation and testing.', 'Gen. Trias Cavite', '', 'https://www.facebook.com/kiwiiboii')">
    <h3 class="title">Member</h3>
    <div class="content">
 
        <div class="content-overlay"></div>
        <img class="content-image" src="img/about/shawn.jpg" width="300" height="300">
        <div class="content-details fadeIn-bottom fadeIn-left">
          <h3>Shawn Soriano</h3>
        </div>
    
    </div>
  </div>

  <div class="container" onclick="showInfo('Nicole Panganiban', 'Team member focusing on quality assurance.', 'Bailen, Cavite' ,'May 16, 2003', 'https://www.facebook.com/nicole.panganiban.16121')">
    <h3 class="title">Member</h3>
    <div class="content">

        <div class="content-overlay"></div>
        <img class="content-image" src="img/about/nicole.jpg" width="300" height="300">
        <div class="content-details fadeIn-bottom fadeIn-left">
          <h3>Nicole Panganiban</h3>
        </div>
  
    </div>
  </div>

  <div class="container" onclick="showInfo('Jan Ferma', 'Team member focusing on documentation and software testing.', 'Mendez, Cavite', 'September 12, 2002', 'https://www.facebook.com/jan.adddd/')">
    <h3 class="title">Member</h3>
    <div class="content">
      <a href="#">
        <div class="content-overlay"></div>
        <img class="content-image" src="img/about/jann.jpg" width="300" height="300">
        <div class="content-details fadeIn-bottom fadeIn-left">
          <h3>Jan Ferma</h3>
        </div>
      </a>
    </div>
  </div>
  <div id="info-section" class="info-section">
    <div class="info-title" id="info-title"></div>
    <div class="info-content" id="info-content"></div>
    <div id="info-address" class="info-content"></div>
    <div id="info-birthday" class="info-content"></div>
    <div id="info-facebook" class="info-content"></div>
  </div>

  <div class="back-button">
    <a href="home.php">Go Back to Home</a>
  </div>

  <script>
    function showInfo(name, description, address, birthday, facebook) {
      const containers = document.querySelectorAll('.container');
      const infoSection = document.getElementById('info-section');

   
      document.getElementById('info-title').textContent = name;
      document.getElementById('info-content').textContent = description;
      document.getElementById('info-address').textContent = 'Address: ' + address;
      document.getElementById('info-birthday').textContent = 'Birthday: ' + birthday;
      document.getElementById('info-facebook').innerHTML = 'Facebook: <a href="' + facebook + '" target="_blank">Click Here</a>';
      infoSection.classList.add('active');


      containers.forEach(container => {
        container.addEventListener('click', function () {
          container.appendChild(infoSection); 
          infoSection.style.display = 'block';
        });
      });

  
      document.addEventListener('click', function closeInfo(event) {
        if (!infoSection.contains(event.target) && !event.target.closest('.container')) {
          infoSection.style.display = 'none';
          infoSection.classList.remove('active');
          document.removeEventListener('click', closeInfo);
        }
      });
    }
  </script>
</body>
</html>
