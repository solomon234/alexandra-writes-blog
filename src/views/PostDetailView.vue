<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRoute } from 'vue-router'
import { getAllPosts } from '../utils/posts'
import { marked } from 'marked'

const route = useRoute()
const post = ref(null)
const loading = ref(true)

onMounted(() => {
  const { category, year, month, day, slug } = route.params
  const allPosts = getAllPosts()
  
  post.value = allPosts.find(p => 
    p.category === category &&
    p.year === year &&
    p.month === month &&
    p.day === day &&
    p.slug === slug
  )
  
  loading.value = false
})

const renderedContent = computed(() => {
  if (!post.value) return ''
  if (post.value.isMarkdown) {
    return marked(post.value.content)
  }
  return post.value.content.replace(/\n/g, '<br>')
})
</script>

<template>
  <div class="post-detail">
    <div v-if="loading" class="loading">Loading post...</div>
    <div v-else-if="post" class="post-container">
      <router-link to="/" class="back-link">← Back to Home</router-link>
      
      <article class="full-post">
        <header class="post-header">
          <span class="post-category">{{ post.category }}</span>
          <h1>{{ post.title }}</h1>
          <div class="post-meta">
            <span class="post-date">📅 {{ post.date }}</span>
          </div>
        </header>

        <div v-if="post.image" class="post-image-container">
          <img :src="post.image" :alt="post.title" class="post-image" />
        </div>

        <div v-if="post.audio" class="post-media-container">
          <audio controls>
            <source :src="post.audio" type="audio/mp4" />
            Your browser does not support the audio element.
          </audio>
        </div>

        <div class="post-content" v-html="renderedContent"></div>
      </article>
    </div>
    <div v-else class="not-found">
      <p>Oops! This story seems to have wandered off into another world.</p>
      <router-link to="/">Go back home</router-link>
    </div>
  </div>
</template>

<style scoped>
.post-detail {
  max-width: 800px;
  margin: 0 auto;
  padding: 2rem 1rem;
}

.back-link {
  display: inline-block;
  margin-bottom: 2rem;
  color: #5d9cec;
  text-decoration: none;
  font-weight: bold;
}

.back-link:hover {
  text-decoration: underline;
}

.full-post {
  background: white;
  border-radius: 15px;
  box-shadow: 0 10px 20px rgba(0,0,0,0.1);
  overflow: hidden;
  border: 4px solid #ffde7d;
}

.post-header {
  padding: 2rem;
  background-color: #fdfcf0;
  border-bottom: 2px dashed #ffde7d;
  text-align: center;
}

.post-category {
  display: inline-block;
  padding: 0.2rem 0.8rem;
  background-color: #5d9cec;
  color: white;
  border-radius: 20px;
  font-size: 0.9rem;
  text-transform: capitalize;
  margin-bottom: 1rem;
}

.post-header h1 {
  margin: 0;
  color: #333;
  font-size: 2.5rem;
}

.post-meta {
  margin-top: 1rem;
  color: #888;
}

.post-image-container {
  width: 100%;
  max-height: 500px;
  overflow: hidden;
}

.post-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.post-media-container {
  padding: 1rem 2rem;
  background: #f9f9f9;
  border-bottom: 1px solid #eee;
  display: flex;
  justify-content: center;
}

.post-media-container audio {
  width: 100%;
}

.post-content {
  padding: 2rem;
  line-height: 1.8;
  font-size: 1.1rem;
  color: #444;
}

.post-content :deep(p) {
  margin-bottom: 1.5rem;
}

.post-content :deep(img) {
  max-width: 100%;
  border-radius: 8px;
}

.not-found {
  text-align: center;
  padding: 4rem;
}

@media (max-width: 600px) {
  .post-header h1 {
    font-size: 1.8rem;
  }
}
</style>
