export const initialState = {
  settings: false,
  healthbar: 100,
  armorbar: 100,
  foodbar: 100,
  waterbar: 100,
  stressbar: 66,
  oxygenbar: 100,
  voicebar: 25,
  bleedAmount: 0,
  display: {
    healthbar: false,
    armorbar: false,
    foodbar: false,
    waterbar: false,
    stressbar: false,
    oxygenbar: false,
    voicebar: false,
  },
};

const appReducer = (state = initialState, action) => {
  switch (action.type) {
    case 'APP_DISPLAY':
      return { ...state, ...action.payload };
    case 'APP_UPDATE':
      return { ...state, ...action.payload };
    case 'SETTINGS_SHOW':
      return { ...state, settings: true };
    case 'SETTINGS_HIDE':
      return { ...state, settings: false };
    default:
      return state;
  }
};

export default appReducer;
