import React from 'react';
import './fonts.css';
import { storiesOf } from '@storybook/react';

storiesOf('Typograpy|Headings', module)
   .add('Heading 1', () => <h1 style={{
      color: `linear-gradient(0.35turn, #66BDA4, #007F90)`,
      fontFamily: `Josefin Sans`,
      fontSize: `2em`,
      marginBottom: `1.45rem`,
    }}>Test</h1>)
   .add('Heading 2', () => <h2 style={{
     color: `linear-gradient(0.35turn, #66BDA4, #007F90)`,
     fontFamily: `Anton`,
     marginBottom: `1.45rem`,
    }}>Test</h2>)
   .add('Heading 3', () => <h3 style={{
     color: `linear-gradient(0.35turn, #66BDA4, #007F90)`,
     fontFamily: `Bungee Inline`,
     marginBottom: `1.45rem`,
   }}>Test</h3>);
