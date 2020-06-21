import React from 'react';
import ReactDOM from 'react-dom';
import { configureStore } from '@reduxjs/toolkit';
import { Provider } from 'react-redux';
import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import uncamelizedGon from 'gon';
import '@fortawesome/react-fontawesome';

import App from './components/App.jsx';
import reducer, { setupState } from './slices/index.js';
import resources from '../locales/index.js';
import { camelize } from './utils/keysConverter.js';
import EntityContext from './EntityContext.js';

export default async () => {
  const gon = camelize(uncamelizedGon);
  await i18n
    .use(initReactI18next)
    .init({
      resources,
      load: 'languageOnly',
      fallbackLng: false,
      lng: gon.locale,
      debug: process.env.NODE_ENV !== 'production',
      react: {
        wait: true,
      },
    });
  const store = configureStore({
    reducer,
  });
  store.dispatch(setupState(gon));

  const entities = {
    lesson: gon.lesson,
    language: gon.language,
  };

  ReactDOM.render(
    <Provider store={store}>
      <EntityContext.Provider value={entities}>
        <App />
      </EntityContext.Provider>
    </Provider>,
    document.querySelector('#basics-lesson-container'),
  );
};
