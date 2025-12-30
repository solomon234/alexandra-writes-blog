export function parsePostContent(content, filePath) {
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

    const [key, ...valueParts] = line.split(':')
    const value = valueParts.join(':').trim()
    metadata[key.trim()] = value
  }

  // Extract content (everything after the metadata)
  const postContent = lines.slice(contentStartIndex).join('\n')

  // Extract category, date info from file path
  // Format: ./posts/category/year/month/day/filename.txt or filename.md
  // In Vite import.meta.glob, paths might be relative to the glob pattern or absolute
  // Based on App.vue: const pathParts = filePath.split('/')
  const pathParts = filePath.split('/')
  // If path is ./posts/stories/2025/06/23/a-portal-to-another-world.md
  // pathParts: [".", "posts", "stories", "2025", "06", "23", "a-portal-to-another-world.md"]
  const category = pathParts[2]
  const year = pathParts[3]
  const month = pathParts[4]
  const day = pathParts[5]
  const filenameFull = pathParts[6]
  const isMarkdown = filenameFull.endsWith('.md')
  const filename = filenameFull.replace('.txt', '').replace('.md','')

  return {
    id: `${category}-${year}-${month}-${day}-${filename}`,
    title: metadata.title,
    date: metadata.date,
    image: metadata.image,
    content: postContent,
    isMarkdown: isMarkdown,
    category: category,
    year: year,
    month: month,
    day: day,
    slug: filename
  }
}

export function getAllPosts() {
  const postFiles = import.meta.glob('../posts/**/*.{txt,md}', { query: '?raw', import: 'default', eager: true })
  
  return Object.entries(postFiles).map(([path, content]) => {
    return parsePostContent(content, path)
  }).sort((a, b) => {
    if (a.year !== b.year) return b.year - a.year
    if (a.month !== b.month) return b.month - a.month
    return b.day - a.day
  })
}
