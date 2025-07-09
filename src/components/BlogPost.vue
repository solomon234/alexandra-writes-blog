<script setup>
import { computed, onMounted } from 'vue'
import { marked } from 'marked'
import TableOfContents from './TableOfContents.vue'

const props = defineProps({
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
  },
  isMarkdown: {
    type: Boolean,
    default: false
  }
})

// Configure marked to add IDs to headings
onMounted(() => {
  const renderer = new marked.Renderer()

  // Override the heading renderer to add IDs
  renderer.heading = function(text, level) {
    const id = text.toLowerCase().replace(/[^\w\s-]/g, '').replace(/\s+/g, '-')
    return `<h${level} id="${id}">${text}</h${level}>`
  }

  marked.setOptions({ renderer })
})

// Parse markdown content to HTML
const parsedContent = computed(() => {
  if (props.isMarkdown) {
    return marked(props.content)
  }
  return props.content
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
      <div v-if="isMarkdown">
        <TableOfContents :content="content" />
        <div class="content-text markdown-content" v-html="parsedContent"></div>
      </div>
      <div v-else class="content-text">
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

.markdown-content {
  /* Override pre-line for markdown content */
  white-space: normal;
}

.markdown-content h1,
.markdown-content h2,
.markdown-content h3,
.markdown-content h4,
.markdown-content h5,
.markdown-content h6 {
  margin-top: 1.5rem;
  margin-bottom: 1rem;
  font-weight: bold;
}

.markdown-content h1 { font-size: 2rem; }
.markdown-content h2 { font-size: 1.75rem; }
.markdown-content h3 { font-size: 1.5rem; }
.markdown-content h4 { font-size: 1.25rem; }
.markdown-content h5 { font-size: 1.1rem; }
.markdown-content h6 { font-size: 1rem; }

.markdown-content p {
  margin-bottom: 1rem;
}

.markdown-content ul,
.markdown-content ol {
  margin-left: 2rem;
  margin-bottom: 1rem;
}

.markdown-content li {
  margin-bottom: 0.5rem;
}

.markdown-content a {
  color: #0066cc;
  text-decoration: underline;
}

.markdown-content a:hover {
  color: #004499;
}

.markdown-content blockquote {
  border-left: 4px solid #ccc;
  padding-left: 1rem;
  margin-left: 0;
  margin-bottom: 1rem;
  color: #666;
  font-style: italic;
}

.markdown-content code {
  background-color: #f5f5f5;
  padding: 0.2rem 0.4rem;
  border-radius: 3px;
  font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
  font-size: 0.9em;
}

.markdown-content pre {
  background-color: #f5f5f5;
  padding: 1rem;
  border-radius: 5px;
  overflow-x: auto;
  margin-bottom: 1rem;
}

.markdown-content pre code {
  background: none;
  padding: 0;
}

.markdown-content strong {
  font-weight: bold;
}

.markdown-content em {
  font-style: italic;
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
