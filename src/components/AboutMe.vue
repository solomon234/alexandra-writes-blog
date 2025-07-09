<script setup>
// AboutMe.vue - A fun about me page for Alexandra's blog
</script>

<template>
  <div class="about-me">
    <h2 class="about-me-title">All About Alexandra!</h2>
    
    <div class="about-me-content">
      <img 
        src="/assets/images/alexandra-drawing.jpg"
        alt="Alexandra drawing" 
        class="about-me-image"
      />
      
      <div class="about-me-text">
        <h3>Hi there! I'm Alexandra!</h3>
        <p>I'm 9 years old and I love writing stories, playing video games and reading!</p>
        
        <h3>My Favorite Things:</h3>
        <ul class="favorites-list">
          <li>🎮 Video Games like Roblox and PKXD</li>
          <li>🍣 Eating Sushi</li>
          <li>📚 Reading Horror and Mystery Books</li>
          <li>🧪 Writing Stories</li>
          <li>🍦 Cupcake Ice Cream</li>
        </ul>
        
        <h3>Fun Facts About Me:</h3>
        <ul class="fun-facts-list">
          <li>I sometimes make romantic stories</li>
          <li>I really like anime</li>
          <li>I love the new movie K pop demon hunters!</li>
          <li>I want to be a singer when I grow up</li>
        </ul>
        
        <h3>My Hobbies:</h3>
        <p>When I'm not writing stories for my blog, I'm talking, drawing, playing piano and painting.</p>
        
        <div class="special-message">
          <p>Thanks for visiting my blog! I hope you like my stories and adventures!</p>
          <p class="signature">~ Alexandra 💖</p>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.about-me {
  background-color: white;
  border-radius: 12px;
  padding: 2rem;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.about-me-title {
  text-align: center;
  color: #ff6b6b;
  text-shadow: 1px 1px 0px #ffde7d;
  margin-bottom: 1.5rem;
}

.about-me-content {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.about-me-image {
  max-width: 100%;
  border-radius: 12px;
  border: 4px solid #ffde7d;
  align-self: center;
  max-height: 400px;
  object-fit: cover;
}

.about-me-text {
  flex: 1;
}

.about-me-text h3 {
  margin-top: 1.5rem;
  margin-bottom: 0.5rem;
}

.favorites-list, .fun-facts-list {
  list-style-type: none;
  padding-left: 0.5rem;
}

.favorites-list li, .fun-facts-list li {
  margin-bottom: 0.5rem;
  position: relative;
  padding-left: 1.5rem;
}

.favorites-list li:before {
  content: "★";
  color: #5d9cec;
  position: absolute;
  left: 0;
}

.fun-facts-list li:before {
  content: "✦";
  color: #a178df;
  position: absolute;
  left: 0;
}

.special-message {
  margin-top: 2rem;
  padding: 1rem;
  background-color: #fff8e1;
  border: 2px dashed #ffde7d;
  border-radius: 12px;
  text-align: center;
}

.signature {
  font-family: 'Comic Sans MS', cursive;
  font-size: 1.2rem;
  color: #ff6b6b;
  margin-top: 0.5rem;
}

@media (min-width: 768px) {
  .about-me-content {
    flex-direction: row;
  }
  
  .about-me-image {
    max-width: 40%;
  }
}
</style>