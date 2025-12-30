<script setup>
import BlogHeader from './components/BlogHeader.vue'
import BlogFooter from './components/BlogFooter.vue'
</script>

<template>
  <div class="blog-container">
    <BlogHeader />

    <main class="blog-content">
      <router-view />
    </main>

    <BlogFooter />
  </div>
</template>

<style scoped>
.blog-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.blog-content {
  flex: 1;
  padding: 0 1rem;
}
</style>
