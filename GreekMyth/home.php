<?php
  session_start();
  if(isset($_SESSION['user_id']) && isset($_COOKIE['user_id'])){
    echo "<script>window.location.href = 'index.php'</script>";
  }
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GreekMyth</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/vanilla-framework/3.0.0/vanilla.min.css">
  <link rel="stylesheet" href="styles/greek.css">
  <link rel="icon" href="img/misc/logo_transparent.png">
</head>
<body>

  <div id="loading-screen">
    <div id="zeus-figure"></div>
  </div>

  <header>
    <h1>GREEK MYTHOLOGY</h1>
    <p>Content Management System</p>
    <a href="about.php">About Us</a>
  </header>

  <main>
    <?php if(isset($_GET['error'])):?>
      <p class="session-error"><?php echo $_GET['error']; ?></p>
    <?php endif; ?>

    <section id="introduction">
      <h2>Introduction</h2>
      <p>
        GreekMyth is an interactive platform designed for mythology enthusiasts to explore their creativity by 
        crafting and sharing their own Greek mythology-inspired stories.
         The platform fosters a vibrant community where users can connect, collaborate, and immerse themselves in a world of myths. 
         GreekMyth offers a unique opportunity for users to not only create stories but also participate in mythological challenges and events that spark imagination. 
         The platform includes a user-friendly interface that allows for seamless storytelling, with customizable elements inspired by ancient Greece.
         Users can engage with other creators, give feedback, and join collaborative projects to build expansive mythological worlds together. 
      </p>
      <p>
        Additionally, GreekMyth provides resources, including ancient mythological references, to inspire and guide creators in their storytelling journey. 
        Whether you are a seasoned mythologist or a newcomer, GreekMyth is a space for all to explore and share their passion for mythology. 
        GreekMyth also includes a rating and rewards system, where users can earn recognition for their creativity and contributions to the community.
         Regular updates and new features are planned to keep the platform fresh and engaging, ensuring that it remains an exciting space for mythological enthusiasts to explore, share, and grow together.
      </p>
      <button class="interactive-btn" id="quiz" onclick="startQuiz()">Test Your Knowledge</button>

      <a href="auth/login.php" class="interactive-btn right">Proceed to Login</a>
    </section>


    <div id="quiz-container">
      <h2>Greek Mythology Quiz</h2>
      <div class="quiz-question">Who is the king of the Greek gods?</div>
      <div class="quiz-option" onclick="checkAnswer('Zeus')">Zeus</div>
      <div class="quiz-option" onclick="checkAnswer('Hades')">Hades</div>
      <div class="quiz-option" onclick="checkAnswer('Poseidon')">Poseidon</div>
      <div class="quiz-option" onclick="checkAnswer('Apollo')">Apollo</div>
    </div>
  </main>

  <footer>
    <p>&copy; Greek Mythology </p>
  </footer>

  <script>

    setTimeout(function () {
      document.getElementById('loading-screen').style.display = 'none';
    }, 5000);


    function startQuiz() {
      document.getElementById('quiz-container').style.display = 'block';
    }

 
    function checkAnswer(answer) {
      if (answer === 'Zeus') {
        alert('Correct! Zeus is the king of the Greek gods.');
      } else {
        alert('Incorrect! Try again.');
      }
      document.getElementById('quiz-container').style.display = 'none';
    }
  </script>
</body>
</html>
