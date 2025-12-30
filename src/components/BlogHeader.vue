<script setup>
// BlogHeader.vue - A fun header for Alexandra's blog
</script>

<template>
  <header class="blog-header">
    <router-link to="/" class="header-link">
      <h1>Alexandra's Awesome Blog</h1>
    </router-link>
    <p class="tagline">Adventures, Stories, and Fun Stuff by a 9-year-old!</p>
    <nav class="blog-nav">
      <router-link 
        to="/" 
        class="nav-button"
        active-class="active"
      >
        Home
      </router-link>
      <router-link 
        to="/about" 
        class="nav-button"
        active-class="active"
      >
        About Me
      </router-link>
    </nav>
  </header>
</template>

<style scoped>
.header-link {
  text-decoration: none;
  color: inherit;
}

.tagline {
  font-size: 1.2rem;
  color: #888;
  margin-top: -0.5rem;
  margin-bottom: 1.5rem;
}

.blog-nav {
  display: flex;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
}

.nav-button {
  display: inline-block;
  padding: 0.5rem 1rem;
  background-color: #5d9cec;
  color: white;
  text-decoration: none;
  border-radius: 8px;
  font-weight: bold;
  border: 2px solid transparent;
  transition: all 0.3s ease;
}

.nav-button:hover {
  background-color: #4a7bc2;
  transform: translateY(-2px);
}

.nav-button.active {
  background-color: #ff6b6b;
  border-color: #ff9e7d;
  box-shadow: 0 3px 0 #e05c5c;
}

@media (max-width: 600px) {
  .blog-nav {
    flex-direction: column;
    align-items: center;
  }
}
</style>
