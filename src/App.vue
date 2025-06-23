<script setup>
import BlogHeader from './components/BlogHeader.vue'
import BlogPost from './components/BlogPost.vue'
import BlogFooter from './components/BlogFooter.vue'
import AboutMe from './components/AboutMe.vue'
import { ref, onMounted } from 'vue'

// Function to parse blog post content from text file
function parsePostContent(content, filePath) {
  const lines = content.split('\n')
  const metadata = {}
  let contentStartIndex = 0

  // Extract metadata (title, date, image)
  for (let i = 0; i < lines.length; i++) {
    const line = lines[i]
    if (line.trim() === '') {
      contentStartIndex = i + 1
      break
    }
    console.log(line)

    const [key, ...valueParts] = line.split(':')
    const value = valueParts.join(':').trim()
    metadata[key.trim()] = value
  }

  // Extract content (everything after the metadata)
  const postContent = lines.slice(contentStartIndex).join('\n')

  // Extract category, date info from file path
  // Format: ./posts/category/year/month/day/filename.txt
  const pathParts = filePath.split('/')
  const category = pathParts[2]
  const year = pathParts[3]
  const month = pathParts[4]
  const day = pathParts[5]
  const filename = pathParts[6].replace('.txt', '')

  return {
    id: `${category}-${year}-${month}-${day}-${filename}`,
    title: metadata.title,
    date: metadata.date,
    image: metadata.image,
    content: postContent,
    category: category,
    year: year,
    month: month,
    day: day,
    slug: filename
  }
}

// Dynamically import all blog post files
const postFiles = import.meta.glob('./posts/**/*.txt', { as: 'raw', eager: true })

// Page navigation
const currentPage = ref('home')

function navigateTo(page) {
  // Only allow valid pages
  if (page === 'home' || page === 'about') {
    currentPage.value = page
  } else {
    console.warn(`Invalid page: ${page}. Redirecting to home.`)
    currentPage.value = 'home'
  }
}

// Parse all blog posts
const allBlogPosts = ref([])
const blogPosts = ref([])
const selectedCategory = ref('all')
const categories = ref([])

// Process all post files
onMounted(() => {
  // Convert the object of modules to an array of posts
  allBlogPosts.value = Object.entries(postFiles).map(([path, content]) => {
    return parsePostContent(content, path)
  }).sort((a, b) => {
    // Sort by date (newest first)
    // Compare year, month, day
    if (a.year !== b.year) return b.year - a.year
    if (a.month !== b.month) return b.month - a.month
    return b.day - a.day
  })

  // Extract unique categories
  const uniqueCategories = new Set(allBlogPosts.value.map(post => post.category))
  categories.value = ['all', ...Array.from(uniqueCategories)]

  // Initialize with all posts
  filterPosts('all')
})

// Function to filter posts by category
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
  <div class="blog-container">
    <BlogHeader 
      :current-page="currentPage"
      @navigate="navigateTo"
    />

    <main class="blog-content">
      <!-- Home Page - Blog Posts -->
      <div v-if="currentPage === 'home'">
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

        <BlogPost 
          v-for="post in blogPosts" 
          :key="post.id"
          :title="post.title"
          :date="post.date"
          :content="post.content"
          :image="post.image"
          :category="post.category"
        />
      </div>

      <!-- About Me Page -->
      <AboutMe v-else-if="currentPage === 'about'" />

      <!-- Fallback - Show home page if currentPage is invalid -->
      <div v-else class="loading-container">
        <p class="loading-message">Redirecting to home page...</p>
      </div>
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
