import { page } from '$app/stores';

export async function GET() {
    return new Response(
        `
    <?xml version="1.0" encoding="UTF-8" ?>
    <urlset
      xmlns="https://www.sitemaps.org/schemas/sitemap/0.9"
      xmlns:xhtml="https://www.w3.org/1999/xhtml"
      xmlns:mobile="https://www.google.com/schemas/sitemap-mobile/1.0"
      xmlns:news="https://www.google.com/schemas/sitemap-news/0.9"
      xmlns:image="https://www.google.com/schemas/sitemap-image/1.1"
      xmlns:video="https://www.google.com/schemas/sitemap-video/1.1"
    >
      <!-- <url> elements go here -->
       <url>
            <loc>https://syrkis.com/</loc>
            <changefreq>weekly</changefreq>
            <priority>1.0</priority>
       </url>
       <url>
            <loc>https://syrkis.com/bciioi</loc>
            <changefreq>weekly</changefreq>
            <priority>0.7</priority>
        </url> 
       <url>
            <loc>https://syrkis.com/erdos</loc>
            <changefreq>weekly</changefreq>
            <priority>0.7</priority>
        </url> 
       <url>
            <loc>https://syrkis.com/aurelian</loc>
            <changefreq>weekly</changefreq>
            <priority>0.7</priority>
        </url> 
       <url>
            <loc>https://syrkis.com/milton</loc>
            <changefreq>weekly</changefreq>
            <priority>0.7</priority>
        </url> 
       <url>
            <loc>https://syrkis.com/harmattan</loc>
            <changefreq>weekly</changefreq>
            <priority>0.7</priority>
        </url> 
    </urlset>`.trim(),
        {
            headers: {
                'Content-Type': 'application/xml'
            }
        }
    );
}