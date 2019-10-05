import { Link } from 'gatsby'
import PropTypes from 'prop-types'
import React from 'react'
import logo from '../../images/TN_logo_White.svg'

const Header = ({ siteTitle }) => (
   <div>
     <div style={{
       position: `relative`,
       height: `80px`
     }}>
       <div
          style={{
            background: `linear-gradient(to right,rgba(47,62,83,.8),rgba(56,74,99,.8),rgba(47,62,83,.8),rgba(47,62,83,.8))`,
            position: `fixed`,
            width: `100%`,
            height: `60px`
          }}
       >
         <div
            style={{
              margin: `0 auto`,
              maxWidth: `100%`,

            }}
         >
           <Link
              to="/"
              style={{
                color: `white`,
                textDecoration: `none`,
              }}
           >
             <div style={{
               maxWidth: 200
             }}>
               <img src={logo} />
             </div>

           </Link>
         </div>
       </div>
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
