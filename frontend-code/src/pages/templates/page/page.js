import React from 'react'
import { graphql } from 'gatsby'

import Layout from '../../../components/layout'
import SEO from '../../../components/seo'

const pageTemplate = ({ data }) => {

  const pages = data.nodePage

  const pageBuilder = []

    let columns = []
    for (const [pbindex, pbvalue] of pages.relationships.field_page_builder.entries()) {
      for (const [pcindex, pcvalue] of pbvalue.relationships.field_column.entries()) {
        let content = []
        let width = []
        if(pcvalue.relationships.field_content !== null) {
          for (const [pcontentindex, pcontentvalue] of pcvalue.relationships.field_content.entries()) {

            if (pcontentvalue.__typename === "paragraph__image") {
              content.push(<img key={`img${pcontentindex}`} src={pcontentvalue.relationships.field_media.relationships.field_media_image.localFile.url} />)
            }
            if (pcontentvalue.__typename === "paragraph__text") {
              content.push(<p key={`text${pcontentindex}`}>{pcontentvalue.field_textarea.value}</p>)
            }
          }
        }
        if(pcvalue.field_width === "Full") {
          width = '1'
        } else {
          width = pcvalue.field_width
        }
        columns.push(<div style={{width: `calc(${width}* 100%)`, float: `left` }}>{content}</div>)
      }

    }

    pageBuilder.push(<section key={pages.drupal_id} style={{clear: `both`}}><a href={pages.path.alias}><h2>{pages.title}</h2></a>{columns}</section>)


  return (
     <Layout>
       <SEO title='' keywords={[`gatsby`, `application`, `react`]}/>
       {pageBuilder}
     </Layout>
  )
}

export default pageTemplate


export const query = graphql`
  query pageQuery($drupal_id: String) {
    nodePage(drupal_id: {eq: $drupal_id}) {
      title
      created
      status
      path {
        alias
      }
      relationships {
        field_page_builder {
          relationships {
            field_column {
              field_width
              relationships {
                field_content {
                  ... on paragraph__text {
                    field_textarea {
                      value 
                    }
                  }
                  ... on paragraph__image {
                    relationships {
                      field_media {
                        name
                        relationships {
                          field_media_image {
                            localFile {
                              url
                              ext
                              extension
                            }
                            relationships {
                              media__image {
                                id
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }  
`

