import { Link } from 'gatsby'
import PropTypes from 'prop-types'
import React from 'react'
import logo from '../images/logo.svg'

const Header = ({ siteTitle }) => (
  <div
    style={{
      marginBottom: `0  `,
      borderBottom: `1px solid #ddd`,
      boxShadow: `0 0 20px #ddd`
    }}
  >
    <div
      style={{
        margin: `0 auto`,
        padding: `0`,
      }}
    >
        <Link
          to="/"
          style={{
            color: `white`,
            textDecoration: `none`,
            margin: 0,
            height: `100%`,
            display: `block`
          }}
        >
        <img src={logo} style={{margin: 0, display: `block`}}/>
        </Link>
    </div>
  </div>
)

Header.propTypes = {
  siteTitle: PropTypes.string,
}

Header.defaultProps = {
  siteTitle: ``,
}

export default Header
