<script setup>
// BlogHeader.vue - A fun header for Alexandra's blog
defineProps({
  currentPage: {
    type: String,
    default: 'home'
  }
})

const emit = defineEmits(['navigate'])

function navigateTo(page) {
  emit('navigate', page)
}
</script>

<template>
  <header class="blog-header">
    <h1>Alexandra's Awesome Blog</h1>
    <p class="tagline">Adventures, Stories, and Fun Stuff by a 9-year-old!</p>
    <nav class="blog-nav">
      <button 
        @click="navigateTo('home')" 
        :class="{ active: currentPage === 'home' }"
      >
        Home
      </button>
<!--      <button>My Stories</button>-->
<!--      <button>Books I Read</button>-->
      <button 
        @click="navigateTo('about')" 
        :class="{ active: currentPage === 'about' }"
      >
        About Me
      </button>
    </nav>
  </header>
</template>

<style scoped>
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

.blog-nav button.active {
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
