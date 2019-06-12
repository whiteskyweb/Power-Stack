import React from 'react'
import { Link } from 'gatsby'

import Layout from '../components/layout'
import Image from '../components/image'
import SEO from '../components/seo'

const IndexPage = () => (
  <Layout>
    <SEO title="Home" keywords={[`gatsby`, `application`, `react`]} />
    <h1><em>Introducing</em> Power Stack</h1>
    <p>A powerful web-stack that makes everyone happy!</p>
    <p>Customers like your site because your site it is fast!</p>
    <p>Marketers can add pages simply and easily</p>
    <p> Developers can use modern web technologies </p>

    <div style={{ maxWidth: `300px`, marginBottom: `1.45rem` }}>
    </div>
  </Layout>
)

export default IndexPage
