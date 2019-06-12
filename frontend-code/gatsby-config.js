require("dotenv").config({
  path: `../../.env`,
})

module.exports = {
  siteMetadata: {
    title: `${process.env.HOST} Power Stack`,
    description: `Kick off your next, great Gatsby project with this default starter. This barebones starter ships with the main Gatsby configuration files you might need.`,
    author: `@xaviemirmon`,
  },
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
        icon: `src/images/logo.png`, // This path is relative to the root of the site.
      },
    },
    'gatsby-plugin-offline',
    {
      resolve: `gatsby-source-drupal`,
      options: {
        baseUrl: `http://${process.env.API_HOST}/`,
        apiBase: `api`, // optional, defaults to `jsonapi`
      },
    },
  ],
}
