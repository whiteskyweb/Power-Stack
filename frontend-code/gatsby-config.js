require("dotenv").config({
  path: `../../.env`,
})

module.exports = {
  siteMetadata: {
    title: `${process.env.HOST} http://${process.env.API_HOST}/`,
    description: `Kick off your next, great Gatsby project with this default starter. This barebones starter ships with the main Gatsby configuration files you might need.`,
    author: `@xaviemirmon`,
  },
  pathPrefix: `/preview`,
  plugins: [
    `gatsby-plugin-react-helmet`,
    {
      resolve: `gatsby-source-filesystem`,
      options: {
        name: `images`,
        path: `${__dirname}/src/images`,
      },
    },
    `gatsby-transformer-sharp`,
    `gatsby-plugin-sharp`,
    {
      resolve: `gatsby-plugin-manifest`,
      options: {
        name: `gatsby-starter-default`,
        short_name: `starter`,
        start_url: `/`,
        background_color: `#fff35c`,
        theme_color: `#fff35c`,
        display: `minimal-ui`,
        icon: `src/images/TN_logo.svg`, // This path is relative to the root of the site.
      },
    },
    'gatsby-plugin-offline',
    {
      resolve: `gatsby-source-drupal-preview`,
      options: {
        baseUrl: `https://master-7rqtwti-shreqbivaapoy.eu-2.platformsh.site/`,
        preview: true,
        apiBase: `api`, // optional, defaults to `jsonapi`
        basicAuth: {
          username: `admin`,
          password: `t3st3r`,
        },
      },
    },
    // 'gatsby-plugin-netlify-cache',
  ],
}
