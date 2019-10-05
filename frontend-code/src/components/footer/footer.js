import React from 'react'

const Footer = () => (
   <footer style={{
     position: `relative`,
     clear: `both`
   }}>
     © {new Date().getFullYear()}, {` `}
     <a href="https://powerstack.dev">Power Stack</a>
     {` `}
     Built with ♥ in Brighton
   </footer>

)


export default Footer
