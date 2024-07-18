const initialState = {
  playerName: { lastname: 'Wyatt', firstname: 'Bryan' },
  accountBalance: 31912,
  accountId: null,
  nearbyPlayersNames: {
    '1': { lastname: 'Doe', firstname: 'John' },
    '2': { lastname: 'Prince', firstname: 'Bobby' },
    '3': { lastname: 'Wu', firstname: 'Henry' },
    '4': { lastname: 'Carpenter', firstname: 'Orlando' },
  },
  transactionHistory: [
    { transaction: 'You deposited $4,675' },
    { transaction: 'You withdrew $4,675' },
    { transaction: '$4,675 sent to Travis Black' },
    { transaction: '$4,675 received from Randy Bullet' },
  ],
  disableDeposit: false,
};

export default (state = initialState, action) => {
  switch (action.type) {
    case 'BANK_SET_DATA':
      return { ...state, ...action.payload };
    case 'SET_ACCOUNT_ID':
      return { ...state, accountId: action.payload };
    default:
      return state;
  }
};
