import React, { useState } from 'react';
import PropTypes from 'prop-types';
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import CssBaseline from '@mui/material/CssBaseline';
import Divider from '@mui/material/Divider';
import Drawer from '@mui/material/Drawer';
import IconButton from '@mui/material/IconButton';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import MenuIcon from '@mui/icons-material/Menu';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import AccountCircle from '@mui/icons-material/AccountCircle';
import MenuItem from '@mui/material/MenuItem';
import Menu from '@mui/material/Menu';
import { Route, Routes, Link, useLocation, } from 'react-router-dom';
import Users from './Components/Users';
import AgeGroup from './Components/AgeGroup';
import Reminder from './Components/Reminder';
import UploadVideos from './Components/UploadVideos';
import Brushing from './Components/Brushing';
import OralHygiene from './Components/OralHygiene';
import Dietaryintake from './Components/Dietaryintake';
import DashboardIcon from '@mui/icons-material/Dashboard';






const drawerWidth = 240;

const ResponsiveDrawer = (props) => {
  const { window } = props;
  const [mobileOpen, setMobileOpen] = useState(false);
  const [anchorEl, setAnchorEl] = useState(null);


  const handleDrawerToggle = () => {
    setMobileOpen(!mobileOpen);
  };

  const handleMenu = (event) => {
    setAnchorEl(event.currentTarget);
  };

  const handleClose = () => {
    setAnchorEl(null);
  };


  const location = useLocation(); // Add this line to get the current location


  const drawer = (
    <div>

      <Toolbar />
      <Divider />
      <List className='sidebar-sty'>
        <ListItem disablePadding className='inner-box'>
          <Link to={'/Admin/'} className={`sidebar-btn ${location.pathname === '/Admin/' ? 'active-link' : ''}`} onClick={handleDrawerToggle}>
            <ListItemButton >
              <ListItemIcon>
                <DashboardIcon />
              </ListItemIcon>
              <ListItemText primary='DashBoard' />
            </ListItemButton>
          </Link>
        </ListItem>
        <ListItem disablePadding className='inner-box'>
          <Link to={'/Admin/Age'}  className={`sidebar-btn ${location.pathname === '/Admin/Age' ? 'active-link' : ''}`} onClick={handleDrawerToggle} >
            <ListItemButton >
              <ListItemIcon>
              <DashboardIcon />
              </ListItemIcon>
              <ListItemText primary='Age' />
            </ListItemButton>
          </Link>
        </ListItem>
        <ListItem disablePadding className='inner-box'>
          <Link to={'/Admin/Reminder'}  className={`sidebar-btn ${location.pathname === '/Admin/Reminder' ? 'active-link' : ''}`} onClick={handleDrawerToggle} >
            <ListItemButton >
              <ListItemIcon>
              <DashboardIcon />
              </ListItemIcon>
              <ListItemText primary='Reminder' />
            </ListItemButton>
          </Link>
        </ListItem>
        <ListItem disablePadding className='inner-box'>
          <Link to={'/Admin/UploadVideos'}   className={`sidebar-btn ${location.pathname === '/Admin/UploadVideos' ? 'active-link' : ''}`} onClick={handleDrawerToggle}>
            <ListItemButton >
              <ListItemIcon>
              <DashboardIcon />
              </ListItemIcon>
              <ListItemText primary='UploadVideos' />
            </ListItemButton>
          </Link>
        </ListItem>
        <ListItem disablePadding className='inner-box'>
          <Link to={'/Admin/Brushing'}  className={`sidebar-btn ${location.pathname === '/Admin/Brushing' ? 'active-link' : ''}`} onClick={handleDrawerToggle}>
            <ListItemButton >
              <ListItemIcon>
              <DashboardIcon />
              </ListItemIcon>
              <ListItemText primary='Brushing' />
            </ListItemButton>
          </Link>
        </ListItem>
        <ListItem disablePadding className='inner-box'>
          <Link to={'/Admin/OralHygiene'}   className={`sidebar-btn ${location.pathname === '/Admin/OralHygiene' ? 'active-link' : ''}`} onClick={handleDrawerToggle}>
            <ListItemButton >
              <ListItemIcon>
              <DashboardIcon />
              </ListItemIcon>
              <ListItemText primary='OralHygiene' />
            </ListItemButton>
          </Link>
        </ListItem>
        <ListItem disablePadding className='inner-box'>
          <Link to={'/Admin/Dietaryintake'}  className={`sidebar-btn ${location.pathname === '/Admin/Dietaryintake' ? 'active-link' : ''}`} onClick={handleDrawerToggle}>
            <ListItemButton >
              <ListItemIcon>
              <DashboardIcon />
              </ListItemIcon>
              <ListItemText primary='Dietaryintake' />
            </ListItemButton>
          </Link>
        </ListItem>


      </List>

    </div>
  );




  // Remove this const when copying and pasting into your project.
  const container = window !== undefined ? () => window().document.body : undefined;

  return (
    <Box sx={{ display: 'flex' }}>
      <CssBaseline />
      <AppBar
        position="fixed"
        sx={{
          width: { sm: `calc(100% - ${drawerWidth}px)` },
          ml: { sm: `${drawerWidth}px` },
          backgroundColor: 'white !important',
          color:'black !important',
        }}
      >
        <Toolbar>
          <IconButton
            color="inherit"
            aria-label="open drawer"
            edge="start"
            onClick={handleDrawerToggle}
            sx={{ mr: 2, display: { sm: 'none' } }}
          >
            <MenuIcon />
          </IconButton>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            Photos
          </Typography>

          <div>
            <div className='profile-icon'>
              <Typography variant="h7" sx={{ ml: 1,color:'white' }}>Admin</Typography>
              <IconButton
                size="large"
                aria-label="account of current user"
                aria-controls="menu-appbar"
                aria-haspopup="true"
                onClick={handleMenu}
                color="primary"
              >
                <AccountCircle sx={{color:'white'}}/>
              </IconButton>
            </div>
            <Menu
              id="menu-appbar"
              anchorEl={anchorEl}
              anchorOrigin={{
                vertical: 'bottom',
                horizontal: 'right',
              }}
              keepMounted
              transformOrigin={{
                vertical: 'top',
                horizontal: 'right',
              }}
              open={Boolean(anchorEl)}
              onClose={handleClose}
            >
              <MenuItem onClick={handleClose}>Profile</MenuItem>
              <MenuItem onClick={handleClose}>My account</MenuItem>
            </Menu>
          </div>

        </Toolbar>
      </AppBar>
      <Box
        component="nav"
        sx={{ width: { sm: drawerWidth }, flexShrink: { sm: 0 } }}
        aria-label="mailbox folders"
       
      >
        {/* The implementation can be swapped with js to avoid SEO duplication of links. */}
        <Drawer
          container={container}
          variant="temporary"
          open={mobileOpen}
          onClose={handleDrawerToggle}
          ModalProps={{
            keepMounted: true, // Better open performance on mobile.
          }}
          sx={{
            display: { xs: 'block', sm: 'none' },
            '& .MuiDrawer-paper': { boxSizing: 'border-box', width: drawerWidth },
          }}
          
        >
          {drawer}
        </Drawer>
        <Drawer
          variant="permanent"
          sx={{
            display: { xs: 'none', sm: 'block' },
            '& .MuiDrawer-paper': { boxSizing: 'border-box', width: drawerWidth },
          }}
          open
        >
          {drawer}
        </Drawer>
      </Box>
      <Box
        component="main"
        sx={{ flexGrow: 1, p: 3, width: { sm: `calc(100% - ${drawerWidth}px)` } }}
      >
        <Toolbar />

        <Routes>
          <Route path='/' element={<Users />} />
          <Route path='/Age' element={<AgeGroup />} />
          <Route path='/Reminder' element={<Reminder />} />
          <Route path='/UploadVideos' element={<UploadVideos />} />
          <Route path='/Brushing' element={<Brushing />} />
          <Route path='/OralHygiene' element={<OralHygiene />} />
          <Route path='/Dietaryintake' element={<Dietaryintake />} />
        </Routes>


      </Box>
    </Box>
  );
}

ResponsiveDrawer.propTypes = {
  /**
   * Injected by the documentation to work in an iframe.
   * Remove this when copying and pasting into your project.
   */
  window: PropTypes.func,
};

export default ResponsiveDrawer;