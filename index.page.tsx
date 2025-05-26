// Learn more about how to build React pages in Realm: https://redocly.com/docs/realm/extend/how-to/create-react-page
import React from 'react';
import styled from 'styled-components';
import { useThemeHooks } from '@redocly/theme/core/hooks';

import { ArrowRightIcon, Button } from '@redocly/theme';
import { CardWithCode } from './@theme/components/CardWithCode/CardWithCode';
import { Card } from '@redocly/theme/markdoc/components/Cards/Card';
import { Cards } from '@redocly/theme/markdoc/components/Cards/Cards';

//import styled from 'styled-components';
import tisaneBackground from './images/TisaneRedoclyBackground.png';
import gradientBackgroundImage from './images/gradient_background.svg';

//const { useTranslate } = useThemeHooks(); 
//const { translate } = useTranslate();

// temporary workaround
/*
function translate(key, fallback) {
  return fallback;
}
*/

const code = `curl -V -X POST \\
  https://api.tisane.ai/parse \\
  -H "Ocp-Apim-Subscription-Key: your_primary_or_secondary_API_key;_not_needed_on-prem" \\
  -H "Content-Type: application/json" \\
  -d '{
    "language": "en",
    "content": "Hello Tisane API!",
    "settings": {}
  }'
`;

export default function HomePage() {
  const { useTranslate } = useThemeHooks(); 
  const { translate } = useTranslate();
  return (
    <div>
      <HeroContainer>
        <HeroBg />
        <img src={tisaneBackground} alt="Tisane documentation background" style={{ width: '40%', maxWidth: '400px', marginBottom: '5px' }} />

        {/* <Image srcSet={`${require('./images/grid.svg')} light, ${require('./images/grid-dark.svg')} dark`} /> */}    
        <h1>{translate('tisane.documentation.title', 'Tisane Developer Documentation')}</h1>
        <p>{translate('content.contentmoderationandmore', 'NLP platform for social media: content moderation and more')}</p>
        <Button size="large" variant="primary" tone="brand" to="/quickstart/quickstart">
          {translate('navbar.getstarted.label', 'Get started')}
        </Button>
        <CardWithCode
          title={translate('content.quickstart', 'Quickstart')}
          description={translate('content.setup', 'Set up your environment and make your first call.')}
          code={code}
        />
      </HeroContainer>
      <Container>
        <h3>{translate('content.tisane.description1', 'Detect cyberbullying, hate speech, sexual harassment, suicidal behavior, allegations, topics, entities, sentiment, and more, in over 30 languages.')}</h3>
        <p>{translate('content.tisane.description2', 'Tisane is a natural language processing library that: ')}</p>
<ul>
<li>{translate('content.tisane.line1', 'Provides standard NLP functions, e.g. entity extraction, topic detection, sentiment analysis. ')}</li>
<li>{translate('content.tisane.line2', 'Detects problematic content.')}</li>
<li>{translate('content.tisane.line3', 'Provides low-level NLP functionality, such as tokenization, part of speech tagging, disambiguation, morphological analysis. ')}</li>

</ul>
      </Container>
      <Container>
        <h3>{translate('content.tisane.keyfeatures', 'Key Features')}</h3>
        <Feature>
          <ArrowRightIcon />
          <p>{translate('content.tisane.simple', 'Simple to use: Get all insights with just one method, configurable to return what you need. ')}</p>
        </Feature>
        <Feature>
          <ArrowRightIcon />
          <p>{translate('content.tisane.languagesupport', 'Tens of languages supported.')}</p>
        </Feature>
        <Feature>
          <ArrowRightIcon />
          <p>{translate('content.tisane.inout', 'Text in, structured insights out: Send text request, receive insights in a JSON response.')}</p>
        </Feature>
        <Feature>
          <ArrowRightIcon />
          <p>{translate('content.tisane.forcontent', 'Built from scratch for social media content: misspellings, algospeak, bad grammar, jargon.')}</p>
        </Feature>
        <Feature>
          <ArrowRightIcon />
          <p>{translate('content.tisane.granular', 'More granular than any other NLP platform.')}</p>
        </Feature>
        <br />
        <ButtonContainer>
          <Button size="large" tone="brand" to="/quickstart/quickstart">
            {translate('navbar.getstarted.label', 'Get started with Tisane')}
          </Button>
          <Button size="large" tone="brand" to="/guides">
            {translate('group.guides.label', 'Guides')}
          </Button>
          <Button size="large" tone="brand" to="/apis/tisane-api-short">
            {translate('navbar.apireference.label', 'API Reference')}
          </Button>
          
        </ButtonContainer>
      </Container>
<p></p>
    </div>
  );
}

const HeroBg = styled.div`
  width: 100%;
  height: 100%;
  position: absolute;
  top: 0;
  left: 0;
 


  z-index: -1;

  &:before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url(${gradientBackgroundImage});
    background-size: cover;
    filter: blur(60px);
    opacity: 0.7;
  }
  &:after {
    content: '';
    position: absolute;
    inset: 0;
    background-size: cover;
    background-image: url(${gradientBackgroundImage});
    opacity: 0.2;
    .dark & {
      background-image: url(${gradientBackgroundImage});
    }
  }
`;

const HeroContainer = styled.div`
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 32px;
  position: relative;
  .code-line::before {
    color: var(--text-color-disabled);
  }

  span {
    color: var(--text-color-secondary);
  }

  h1 {
    color: var(--color-black-5);
    text-align: center;
    font-size: 48px;
    font-weight: 700;
    line-height: 102px;
    letter-spacing: 1px;
    margin-bottom: 24px;
    margin: 40px 0 24px 0;
  }

  > p {
    color: var(--text-color-primary);
    text-align: center;
    font-size: 20px;
    font-weight: 600;
    line-height: 28px;
    margin: 0 0 24px 0;
  }
`;

const Container = styled.div`
  margin-top: 64px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  color: var(--text-color-secondary);
  font-size: 20px;
  font-weight: 400;
  line-height: 28px;

  width: min(90%, 886px);
  margin: 64px auto 0;
  a {
    text-decoration: none;
  }

  p {
    margin: 0;
  }

  h3 {
    color: var(--text-color-primary);
    font-size: 24px;
    font-weight: 600;
    line-height: 32px;
    margin: 0 0 24px 0;
  }
`;

const Feature = styled.div`
  display: flex;
  align-items: flex-start;
  gap: 8px;

  svg {
    height: 16px;
    width: 16px;
    margin-top: 6px; // Aligns the icon with the first line of text
    flex-shrink: 0; // Prevents the icon from shrinking
    path {
      fill: var(--color-orange-6);
    }
  }
  margin-bottom: var(--spacing-sm);
`;

const ButtonContainer = styled.div`
  display: flex;
  gap: var(--spacing-xs);
  justify-content: center;
  flex-wrap: wrap;
`;

const ContactUsSection = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  margin-bottom: var(--spacing-lg);
  flex-wrap: wrap;
  gap: var(--spacing-xs);
  h3 {
    margin: 0;
  }
`;
