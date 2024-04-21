# URL Shortener
A demo Rails URL Shortener app. Shortening is based on creating a short url with Base62 encryption of the URL index.

Features:
- Base62 encoding and decoding algorithm
- Fetching and saving metadata for websites (icon, title, description)
- Rails background job
- Updating pages with turbo stream
- Copy to clipboard with clibboardJS
- Users and read/delete/edit permissions with Devise
- Integration and model tests
- Github actions for running tests for each push
- Pagination with pagy (buggy)