<script setup>
import { ref, onMounted } from 'vue'
import BlogPost from '../components/BlogPost.vue'
import { getAllPosts } from '../utils/posts'

const allBlogPosts = ref([])
const blogPosts = ref([])
const selectedCategory = ref('all')
const categories = ref([])

onMounted(() => {
  allBlogPosts.value = getAllPosts()

  // Extract unique categories
  const uniqueCategories = new Set(allBlogPosts.value.map(post => post.category))
  categories.value = ['all', ...Array.from(uniqueCategories)]

  // Initialize with all posts
  filterPosts('all')
})

function filterPosts(category) {
  selectedCategory.value = category

  if (category === 'all') {
    blogPosts.value = allBlogPosts.value
  } else {
    blogPosts.value = allBlogPosts.value.filter(post => post.category === category)
  }
}
</script>

<template>
  <div>
    <div v-if="categories.length > 1" class="category-filter">
      <p>Filter by category:</p>
      <div class="category-buttons">
        <button 
          v-for="category in categories" 
          :key="category"
          @click="filterPosts(category)"
          :class="{ active: selectedCategory === category }"
        >
          {{ category === 'all' ? 'All Posts' : category }}
        </button>
      </div>
    </div>

    <div v-if="blogPosts.length === 0 && categories.length === 0" class="loading-container">
      <p class="loading-message">Loading awesome stories...</p>
    </div>

    <div v-else-if="blogPosts.length === 0" class="empty-container">
      <p class="empty-message">No posts found in this category.</p>
    </div>

    <div class="posts-list">
      <BlogPost 
        v-for="post in blogPosts" 
        :key="post.id"
        :title="post.title"
        :date="post.date"
        :content="post.content"
        :image="post.image"
        :category="post.category"
        :is-markdown="post.isMarkdown"
        :slug="post.slug"
        :year="post.year"
        :month="post.month"
        :day="post.day"
      />
    </div>
  </div>
</template>

<style scoped>
.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 200px;
}

.loading-message, .empty-message {
  font-size: 1.5rem;
  color: #5d9cec;
  text-align: center;
  padding: 2rem;
  border: 3px dashed #ffde7d;
  border-radius: 12px;
  background-color: rgba(255, 255, 255, 0.8);
  animation: pulse 1.5s infinite alternate;
}

.empty-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 200px;
}

.category-filter {
  margin-bottom: 2rem;
  text-align: center;
}

.category-filter p {
  font-size: 1.2rem;
  margin-bottom: 0.5rem;
  color: #666;
}

.category-buttons {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 0.5rem;
}

.category-buttons button {
  font-size: 0.9rem;
  padding: 0.4em 0.8em;
  background-color: #f0f0f0;
  color: #666;
  border: 2px solid #ddd;
  box-shadow: none;
  text-transform: capitalize;
}

.category-buttons button:hover {
  background-color: #e0e0e0;
  transform: translateY(-1px);
}

.category-buttons button.active {
  background-color: #5d9cec;
  color: white;
  border-color: #ffde7d;
  box-shadow: 0 2px 0 #4a7bc2;
}

@keyframes pulse {
  from {
    transform: scale(1);
    opacity: 0.8;
  }
  to {
    transform: scale(1.05);
    opacity: 1;
  }
}
</style>
