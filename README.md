# Alexandra's Awesome Blog

A fun, colorful blog website designed for a 9-year-old writer to share stories, adventures, and science experiments. This project is built with Vue 3 and Vite, featuring a responsive design with a child-friendly interface.

![Alexandra's Awesome Blog](https://images.unsplash.com/photo-1588454896638-b6781ded0f87?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2hpbGQlMjBkcmF3aW5nfGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60)

## Features

- 📝 **Blog Post System**: Display blog posts with titles, dates, content, and images
- 🗂️ **Category Filtering**: Filter posts by categories (adventures, stories, science, reviews)
- 📁 **Static Content**: Blog posts are stored as static text files with a simple format
- 👧 **About Me Page**: A dedicated page with information about the blog author
- 📱 **Responsive Design**: Looks great on devices of all sizes
- 🎨 **Child-Friendly UI**: Colorful, fun design with Comic Sans font and playful elements

## Project Structure

```
alexandra-writes-blog/
├── public/               # Public assets
├── src/                  # Source files
│   ├── assets/           # Static assets
│   ├── components/       # Vue components
│   │   ├── AboutMe.vue   # About Me page component
│   │   ├── BlogFooter.vue # Footer component
│   │   ├── BlogHeader.vue # Header with navigation
│   │   └── BlogPost.vue  # Blog post component
│   ├── posts/            # Blog post content files
│   │   ├── adventures/   # Adventure category posts
│   │   ├── science/      # Science category posts
│   │   ├── stories/      # Stories category posts
│   │   └── reviews/      # Reviews category posts
│   ├── App.vue           # Main application component
│   ├── main.js           # Application entry point
│   └── style.css         # Global styles
├── index.html            # HTML entry point
├── package.json          # Project dependencies
└── vite.config.js        # Vite configuration
```

## Blog Post Format

Blog posts are stored as text files in the `src/posts` directory, organized by category, year, month, and day. Each post follows this format:

```
title: My Blog Post Title
date: Month Day, Year
image: URL to an image

The content of the blog post goes here.
Multiple paragraphs are supported.

You can add as many paragraphs as you want.
```

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/alexandra-writes-blog.git
   cd alexandra-writes-blog
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

   This will automatically run the post-install script which prompts you to:
   - Create the necessary directory structure for blog posts (`src/posts/`)
   - Set up four category folders: `adventures`, `stories`, `science`, and `reviews`
   - Create a year/month/day folder structure (2024/06/15) for each category
   - Add an example welcome post in the adventures category

   You can choose yes/no for each prompt to customize your setup.

3. Start the development server:
   ```bash
   npm run dev
   ```

4. Build for production:
   ```bash
   npm run build
   ```

## Usage

### Adding New Blog Posts

1. Create a new text file in the appropriate category folder under `src/posts`
   - Available categories: `adventures`, `stories`, `science`, `reviews`
   - Example: `src/posts/adventures/2024/07/20/summer-camp.txt`

2. Follow the folder structure: `src/posts/[category]/[year]/[month]/[day]/[post-name].txt`
   - Year format: 4 digits (e.g., `2024`)
   - Month format: 2 digits (e.g., `06` for June)
   - Day format: 2 digits (e.g., `15`)
   - Post name: Use kebab-case (e.g., `summer-camp.txt`)

3. Use the blog post format described in the "Blog Post Format" section:
   ```
   title: My Blog Post Title
   date: Month Day, Year
   image: URL to an image

   Your content here...
   ```

   - The `title` can include special characters and spaces
   - The `date` should be in the format "Month Day, Year" (e.g., "June 15, 2024")
   - The `image` should be a URL to an image (can be a local path or external URL)
   - Leave a blank line between the metadata and content
   - Content supports multiple paragraphs separated by blank lines

4. The post will automatically appear in the blog with the correct category and sorting
   - Posts are sorted by date (newest first)
   - The category is determined by the folder structure

### Using the Setup Script

If you need to recreate the blog post directory structure or if you're setting up the project manually, you can run:

```bash
npm run setup
```

This interactive script will:
- Prompt you to create the `src/posts` directory if it doesn't exist
- Ask if you want to set up each of the four category folders: `adventures`, `stories`, `science`, and `reviews`
- Create the year/month/day folder structure (2024/06/15) for each category you approve
- Ask if you want to add an example welcome post in the adventures category
  - Located at: `src/posts/adventures/2024/06/15/welcome-post.txt`
  - Contains a simple welcome message with title, date, and image

The script is interactive and allows you to customize your blog structure by answering yes/no to each prompt. It's also safe to run multiple times - it will only prompt for directories and files that don't already exist.

### Navigation

- Click on the "Home" button to view all blog posts
- Click on the "About Me" button to view information about the blog author
- Use the category filter buttons to view posts from specific categories:
  - The category buttons appear at the top of the home page
  - Click on a category name (adventures, stories, science, reviews) to filter posts
  - Click on "All Posts" to view all posts again
  - The active category button is highlighted
  - If no posts exist in a selected category, a message will be displayed

## Technologies Used

- **Vue.js 3**: Progressive JavaScript framework
- **Vite**: Next-generation frontend tooling
- **CSS3**: Custom styling with animations and responsive design
- **JavaScript ES6+**: Modern JavaScript features

## Troubleshooting

### Common Issues

- **No posts appear on the home page**:
  - Make sure you have created at least one post in the correct format
  - Check that the post files are in the correct directory structure
  - Run `npm run setup` to create the example post
  - Check the browser console for any JavaScript errors

- **Images don't display**:
  - Verify that the image URLs are correct and accessible
  - For local images, make sure they are in the public directory
  - For external images, ensure they are from a source that allows hotlinking

- **Category filter doesn't show all categories**:
  - Categories only appear if there's at least one post in that category
  - Create a post in the missing category to make it appear in the filter

- **Date sorting issues**:
  - Ensure your date format in the post metadata is consistent (Month Day, Year)
  - Check that your folder structure follows the correct format (year/month/day)

## Future Improvements

- Add a commenting system for readers to interact with posts
- Implement a search function to find posts by keyword
- Create a contact form for readers to send messages
- Add more interactive elements like quizzes or games
- Implement a simple admin interface for adding new posts

## License

This project is licensed under the MIT License - see the LICENSE file for details.
