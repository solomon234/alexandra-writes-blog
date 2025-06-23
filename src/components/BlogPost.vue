<script setup>
defineProps({
  title: {
    type: String,
    required: true
  },
  date: {
    type: String,
    required: true
  },
  content: {
    type: String,
    required: true
  },
  image: {
    type: String,
    default: ''
  },
  category: {
    type: String,
    default: ''
  }
})
</script>

<template>
  <article class="blog-post">
    <h2 class="blog-post-title">{{ title }}</h2>
    <p class="blog-post-meta">
      Posted on {{ date }} 
      <span v-if="category" class="blog-post-category">in {{ category }}</span>
    </p>
    <div class="blog-post-content">
      <img v-if="image" :src="image" :alt="title" width="300" height="200" />
      <div class="content-text">
        {{ content }}
      </div>
    </div>
  </article>
</template>

<style scoped>
.blog-post-title {
  transition: transform 0.3s ease;
}

.blog-post-title:hover {
  transform: scale(1.02);
}

.blog-post-content p {
  margin-bottom: 1rem;
}

.content-text {
  white-space: pre-line;
  text-align: left;
  line-height: 1.7;
}

.blog-post-category {
  display: inline-block;
  background-color: #ffde7d;
  color: #333;
  padding: 0.2rem 0.5rem;
  border-radius: 12px;
  font-size: 0.8rem;
  margin-left: 0.5rem;
  font-weight: bold;
  text-transform: capitalize;
}
</style>
