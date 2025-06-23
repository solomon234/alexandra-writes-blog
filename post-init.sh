#!/bin/bash

# Post-initialization script for Alexandra's Awesome Blog
# This script creates the necessary directory structure and example blog post

echo "Running post-init script..."

# Define the base directory for posts
POSTS_DIR="./src/posts"

# Define categories
CATEGORIES=("adventures" "stories" "science" "reviews")

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

# Create the posts directory if it doesn't exist
if [ ! -d "$POSTS_DIR" ]; then
    if confirm "The posts directory doesn't exist. Would you like to create it?"; then
        echo "Creating posts directory..."
        mkdir -p "$POSTS_DIR"
    else
        echo "Skipping posts directory creation."
    fi
fi

# Create category directories
for category in "${CATEGORIES[@]}"; do
    CATEGORY_DIR="$POSTS_DIR/$category"
    if [ ! -d "$CATEGORY_DIR" ]; then
        if confirm "The $category category directory doesn't exist. Would you like to create it?"; then
            echo "Creating $category category directory..."
            mkdir -p "$CATEGORY_DIR"
            
            # Create example year/month/day structure for each category
            echo "Creating year/month/day structure for $category..."
            mkdir -p "$CATEGORY_DIR/2024/06/15"
        else
            echo "Skipping $category category directory creation."
        fi
    fi
done

# Create an example post if none exist
EXAMPLE_POST_PATH="$POSTS_DIR/adventures/2024/06/15/welcome-post.txt"
if [ ! -f "$EXAMPLE_POST_PATH" ]; then
    if confirm "Would you like to create an example blog post?"; then
        echo "Creating example blog post..."
        cat > "$EXAMPLE_POST_PATH" << EOF
title: Welcome to My Awesome Blog!
date: June 15, 2024
image: https://images.unsplash.com/photo-1471107340929-a87cd0f5b5f3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YWR2ZW50dXJlfGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60

Hello and welcome to my blog! My name is Alexandra and I'm 9 years old.

This is my very first blog post! I'm so excited to share my adventures, stories, and science experiments with you.

Stay tuned for more awesome content coming soon!
EOF
    else
        echo "Skipping example blog post creation."
    fi
fi

echo "Post-init script completed successfully!"