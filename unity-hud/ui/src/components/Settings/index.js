import React, { useState } from 'react';
import { useSelector } from 'react-redux';

import { makeStyles } from '@material-ui/core/styles';

import List from '@material-ui/core/List';
import ListItem from '@material-ui/core/ListItem';
import ListItemIcon from '@material-ui/core/ListItemIcon';
import ListItemSecondaryAction from '@material-ui/core/ListItemSecondaryAction';
import ListItemText from '@material-ui/core/ListItemText';
import ListSubheader from '@material-ui/core/ListSubheader';
import Switch from '@material-ui/core/Switch';
import IconButton from '@material-ui/core/IconButton';
import Fade from '@material-ui/core/Fade';

import LocalHospitalIcon from '@material-ui/icons/LocalHospital';
import SecurityIcon from '@material-ui/icons/Security';
import RestaurantIcon from '@material-ui/icons/Restaurant';
import LocalDrinkIcon from '@material-ui/icons/LocalDrink';
import InsertEmoticonIcon from '@material-ui/icons/InsertEmoticon';
import BubbleChartOutlinedIcon from '@material-ui/icons/BubbleChartOutlined';
import SignalWifi3BarIcon from '@material-ui/icons/SignalWifi3Bar';
import CloseIcon from '@material-ui/icons/Close';

import Nui from '../../util/Nui';

const useStyles = makeStyles(theme => ({
  root: {
    width: 250,
    height: 310,
    position: 'absolute',
    top: 0,
    bottom: 0,
    right: 0,
    left: 0,
    margin: 'auto',
    overflow: 'none',
    background: theme.palette.background.default,
  },
  exitButton: {
    position: 'absolute',
    right: 0,
    color: 'red',
  },
  switchBase: {
    color: '#D3D3D3',
    '&$checked': {
      color: '#D3D3D3',
    },
    '&$checked + $track': {
      backgroundColor: '#00ff00',
    },
  },
  checked: {},
  track: {},
}));

const closeUI = async () => {
  await Nui.send('close');
};

export default () => {
  const classes = useStyles();
  const [checked, setChecked] = useState([]);
  const hidden = useSelector(state => state.app.settings);

  const handleToggle = value => async () => {
    const currentIndex = checked.indexOf(value); // -1 if unchecked 0 if checked
    const newChecked = [...checked];

    if (currentIndex === -1) {
      newChecked.push(value);
    } else {
      newChecked.splice(currentIndex, 1);
    }

    setChecked(newChecked);

    await Nui.send('toggle', { value, currentIndex });
  };

  return (
    <Fade in={hidden} timeout={500}>
      <List
        subheader={
          <ListSubheader style={{ marginBottom: -2, color: '#FFFFFF' }}>
            Settings
            <IconButton onClick={closeUI} className={classes.exitButton}>
              <CloseIcon />
            </IconButton>
          </ListSubheader>
        }
        className={classes.root}
        dense
      >
        <ListItem divider>
          <ListItemIcon>
            <LocalHospitalIcon />
          </ListItemIcon>
          <ListItemText id="healthbar" primary="Health Bar" />
          <ListItemSecondaryAction>
            <Switch
              classes={{
                switchBase: classes.switchBase,
                checked: classes.checked,
                track: classes.track,
              }}
              edge="end"
              onChange={handleToggle('healthbar')}
              checked={checked.indexOf('healthbar') !== -1}
              inputProps={{ 'aria-labelledby': 'healthbar' }}
            />
          </ListItemSecondaryAction>
        </ListItem>
        <ListItem divider>
          <ListItemIcon>
            <SecurityIcon className={classes.armorbar} />
          </ListItemIcon>
          <ListItemText
            className={classes.armorbar}
            id="armorbar"
            primary="Armor Bar"
          />
          <ListItemSecondaryAction>
            <Switch
              classes={{
                switchBase: classes.switchBase,
                checked: classes.checked,
                track: classes.track,
              }}
              edge="end"
              onChange={handleToggle('armorbar')}
              checked={checked.indexOf('armorbar') !== -1}
              inputProps={{ 'aria-labelledby': 'armorbar' }}
            />
          </ListItemSecondaryAction>
        </ListItem>
        <ListItem divider>
          <ListItemIcon>
            <RestaurantIcon className={classes.foodbar} />
          </ListItemIcon>
          <ListItemText
            className={classes.foodbar}
            id="foodbar"
            primary="Food Bar"
          />
          <ListItemSecondaryAction>
            <Switch
              classes={{
                switchBase: classes.switchBase,
                checked: classes.checked,
                track: classes.track,
              }}
              edge="end"
              onChange={handleToggle('foodbar')}
              checked={checked.indexOf('foodbar') !== -1}
              inputProps={{ 'aria-labelledby': 'foodbar' }}
            />
          </ListItemSecondaryAction>
        </ListItem>
        <ListItem divider>
          <ListItemIcon>
            <LocalDrinkIcon className={classes.waterbar} />
          </ListItemIcon>
          <ListItemText
            className={classes.waterbar}
            id="waterbar"
            primary="Thirst Bar"
          />
          <ListItemSecondaryAction>
            <Switch
              classes={{
                switchBase: classes.switchBase,
                checked: classes.checked,
                track: classes.track,
              }}
              edge="end"
              onChange={handleToggle('waterbar')}
              checked={checked.indexOf('waterbar') !== -1}
              inputProps={{ 'aria-labelledby': 'waterbar' }}
            />
          </ListItemSecondaryAction>
        </ListItem>
        <ListItem divider>
          <ListItemIcon>
            <InsertEmoticonIcon className={classes.stressbar} />
          </ListItemIcon>
          <ListItemText
            className={classes.stressbar}
            id="stressbar"
            primary="Stress Bar"
          />
          <ListItemSecondaryAction>
            <Switch
              classes={{
                switchBase: classes.switchBase,
                checked: classes.checked,
                track: classes.track,
              }}
              edge="end"
              onChange={handleToggle('stressbar')}
              checked={checked.indexOf('stressbar') !== -1}
              inputProps={{ 'aria-labelledby': 'stressbar' }}
            />
          </ListItemSecondaryAction>
        </ListItem>
        <ListItem divider>
          <ListItemIcon>
            <BubbleChartOutlinedIcon className={classes.oxygenbar} />
          </ListItemIcon>
          <ListItemText
            className={classes.oxygenbar}
            id="oxygenbar"
            primary="Oxygen Bar"
          />
          <ListItemSecondaryAction>
            <Switch
              classes={{
                switchBase: classes.switchBase,
                checked: classes.checked,
                track: classes.track,
              }}
              edge="end"
              onChange={handleToggle('oxygenbar')}
              checked={checked.indexOf('oxygenbar') !== -1}
              inputProps={{ 'aria-labelledby': 'oxygenbar' }}
            />
          </ListItemSecondaryAction>
        </ListItem>
        <ListItem >
          <ListItemIcon>
            <SignalWifi3BarIcon className={classes.voicebar} />
          </ListItemIcon>
          <ListItemText
            className={classes.voicebar}
            id="voicebar"
            primary="Voice Bar"
          />
          <ListItemSecondaryAction>
            <Switch
              classes={{
                switchBase: classes.switchBase,
                checked: classes.checked,
                track: classes.track,
              }}
              edge="end"
              onChange={handleToggle('voicebar')}
              checked={checked.indexOf('voicebar') !== -1}
              inputProps={{ 'aria-labelledby': 'voicebar' }}
            />
          </ListItemSecondaryAction>
        </ListItem>
      </List>
    </Fade>
  );
};
