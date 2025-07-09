<script setup>
import { computed } from 'vue'

const props = defineProps({
  content: {
    type: String,
    required: true
  }
})

// Extract headings from markdown content
const headings = computed(() => {
  const headingRegex = /^(#{2,4})\s+(.+)$/gm
  const matches = [...props.content.matchAll(headingRegex)]
  
  return matches.map(match => {
    const level = match[1].length - 1 // Adjust level (h2 = level 1, h3 = level 2, etc.)
    const text = match[2]
    const id = text.toLowerCase().replace(/[^\w\s-]/g, '').replace(/\s+/g, '-')
    
    return {
      level,
      text,
      id
    }
  })
})

// Check if there are enough headings to show a TOC
const shouldShowToc = computed(() => {
  return headings.value.length >= 2
})
</script>

<template>
  <div v-if="shouldShowToc" class="table-of-contents">
    <h3 class="toc-title">In This Story:</h3>
    <ul class="toc-list">
      <li v-for="heading in headings" :key="heading.id" :class="`toc-level-${heading.level}`">
        <a :href="`#${heading.id}`">{{ heading.text }}</a>
      </li>
    </ul>
  </div>
</template>

<style scoped>
.table-of-contents {
  background-color: #f8f9fa;
  border: 2px solid #ffde7d;
  border-radius: 12px;
  padding: 1rem;
  margin-bottom: 2rem;
  box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
}

.toc-title {
  color: #5d9cec;
  font-size: 1.2rem;
  margin-top: 0;
  margin-bottom: 0.8rem;
  text-align: center;
}

.toc-list {
  list-style-type: none;
  padding-left: 0;
  margin: 0;
}

.toc-level-1 {
  font-weight: bold;
  margin-bottom: 0.5rem;
}

.toc-level-2 {
  padding-left: 1.5rem;
  margin-bottom: 0.3rem;
  font-size: 0.95rem;
}

.toc-level-3 {
  padding-left: 3rem;
  margin-bottom: 0.3rem;
  font-size: 0.9rem;
}

.toc-list a {
  color: #333;
  text-decoration: none;
  transition: color 0.2s ease;
  display: inline-block;
}

.toc-list a:hover {
  color: #ff6b6b;
  transform: translateX(3px);
}

/* Add a fun icon before each item */
.toc-list li::before {
  content: "📖";
  margin-right: 0.5rem;
}

/* Different icons for different levels */
.toc-level-2::before {
  content: "📝" !important;
}

.toc-level-3::before {
  content: "✏️" !important;
}

@media (max-width: 600px) {
  .table-of-contents {
    padding: 0.8rem;
  }
  
  .toc-level-2 {
    padding-left: 1rem;
  }
  
  .toc-level-3 {
    padding-left: 2rem;
  }
}
</style>