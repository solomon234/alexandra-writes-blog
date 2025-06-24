#!/bin/bash

# Post-initialization script for Alexandra's Awesome Blog
# This script creates the necessary directory structure and example blog post

echo "Running post-init script..."

# Define the base directory for posts
POSTS_DIR="./src/posts"
CURRENT_DATE=$(date +%Y/%m/%d)

# Retrieve Existing Categories
CATEGORIES=(`ls -p "$POSTS_DIR"`)

# Function to get user confirmation
confirm() {
    read -p "$1 (y/n): " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

createDirectory() {
  local newDir=$1
  mkdir -p $newDir
  echo "Directory $newDir created"
}

# Enhanced version with validation and options
prompt_metadata_enhanced() {
    local postDir=$1
    echo "=== Create New Post ==="
    echo

    # Title with validation
    while true; do
        read -p "Enter post title: " title
        if [ -n "$title" ]; then
            break
        fi
        echo "Error: Title is required"
    done

    # Date with multiple format options
    echo
    echo "Date options:"
    echo "1. Use current date ($(date +'%B %d, %Y'))"
    echo "2. Enter custom date"
    read -p "Choose option [1]: " date_option
    date_option=${date_option:-1}

    case $date_option in
        1)
            date=$(date +"%B %d, %Y")
            ;;
        2)
            read -p "Enter date (e.g., June 23, 2025): " date
            ;;
        *)
            date=$(date +"%B %d, %Y")
            ;;
    esac

    # Image with suggestions
    echo
    echo "Image options:"
    echo "1. No image"
    echo "2. Enter image path"
    echo "3. Generate path from title"
    read -p "Choose option [1]: " image_option
    image_option=${image_option:-1}

    case $image_option in
        1)
            image=""
            ;;
        2)
            read -p "Enter image path: " image
            ;;
        3)
            # Generate image path from title
            image_name=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
            image="/assets/images/${image_name}.png"
            echo "Generated image path: $image"
            ;;
    esac

    # Body content options
    echo
    echo "Body content options:"
    echo "1. Enter text now"
    echo "2. Create empty file to edit later"
    read -p "Choose option [1]: " body_option
    body_option=${body_option:-1}

    case $body_option in
        1)
            echo "Enter post body (press Ctrl+D when finished, or Ctrl+C to cancel):"
            body=$(cat)
            ;;
        2)
            body="[Content to be added]"
            ;;
    esac

    # Preview before saving
    echo
    echo "Preview of your post:"
    echo "===================="
    echo "title: $title"
    echo "date: $date"
    if [ -n "$image" ]; then
        echo "image: $image"
    fi
    echo
    echo "$body"
    echo "===================="
    echo

    # Confirm creation
    read -p "Create this post? (y/n) [y]: " confirm
    confirm=${confirm:-y}

    if [[ $confirm =~ ^[yY] ]]; then
        create_post_file "$title" "$date" "$image" "$body" "$postDir"
    else
        echo "Post creation cancelled."
    fi
}



# Function to create the post file
create_post_file() {
    local title="$1"
    local date="$2"
    local image="$3"
    local body="$4"
    local postDir="$5"

    # Generate filename from title
    local filename=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
    local post_file="$filename.md"

    # Create the post directory if it doesn't exist
    mkdir -p "$postDir"

    # Create post content in the correct directory
    {
        echo "title: $title"
        echo "date: $date"
        if [ -n "$image" ]; then
            echo "image: $image"
        fi
        echo
        echo "$body"
    } > "$postDir/$post_file"

    echo
    echo "Post created: $postDir/$post_file"
    echo "Preview:"
    echo "----------------------------------------"
    cat "$postDir/$post_file"
}


# Create the posts directory if it doesn't exist
if [ ! -d "$POSTS_DIR" ]; then
    if confirm "The posts directory doesn't exist. Would you like to create it?"; then
        echo "Creating posts directory..."
        createDirectory POSTS_DIR
    else
        echo "Skipping posts directory creation."
    fi
fi
i=1
# Prompt for category
echo "Enter a Category from the List or enter 0 for Other"
for cat in "${CATEGORIES[@]}"; do
    echo "$i : $cat"
    ((i++))
done

echo "0 : Other"

read -p "Enter your choice: " catID

# Validate input is a number
if [[ ! "$catID" =~ ^[0-9]+$ ]]; then
    echo "Error: Please enter a valid number"
    exit 1
fi

if [ "$catID" -eq 0 ]; then
    read -p "Enter custom category name: " category
    echo "You entered custom category: $category"
    catDir="$POSTS_DIR/$category/$CURRENT_DATE"
elif [ "$catID" -ge 1 ] && [ "$catID" -le ${#CATEGORIES[@]} ]; then
    selected_index=$((catID - 1))
    category="${CATEGORIES[$selected_index]}"
    echo "You selected: $selected_category"
    catDir="$POSTS_DIR/$category$CURRENT_DATE"
else
    echo "Error: Invalid selection. Please choose between 0 and ${#CATEGORIES[@]}"
    exit 1
fi
prompt_metadata_enhanced $catDir
echo "Post-init script completed successfully!"