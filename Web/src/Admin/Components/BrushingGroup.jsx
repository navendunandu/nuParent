import React, { Fragment, useLayoutEffect, useState } from 'react'
import { DataGrid } from '@mui/x-data-grid'
import {
   Box,
   Button,
   Container,
   Stack,
   TextField,
   Typography,
   Dialog,
   DialogActions,
   DialogContent,
   DialogContentText,
   DialogTitle,
} from '@mui/material'
import DeleteIcon from '@mui/icons-material/Delete'
import { db } from '../../config/firebase'
import {
   addDoc,
   collection,
   getDocs,
   deleteDoc,
   doc,
   updateDoc,
} from 'firebase/firestore'
import EditNoteIcon from '@mui/icons-material/EditNote'
import FullPageLoader from './FullPageLoader'

const AgeGroup = () => {
   const [open, setOpen] = useState(false)
   const [brushingData, setBrushingData] = useState([])
   const [brushing, setBrushing] = useState('')
   const [selectedRow, setSelectedRow] = useState(null)
   const [selectedDoc, setSelectedDoc] = useState(null)
   const [error, setError] = useState('')
   const [checkLoad, setCheckBlur] = useState(false)

   const handleClickOpen = (params) => {
      setSelectedRow(params)
      setOpen(true)
   }

   const handleClose = () => {
      setOpen(false)
   }

   const addBrushing = async (e) => {
      e.preventDefault() // prevent form submission
      setCheckBlur(true)
      if (!brushing) {
         setError('Brushing is required')
         setCheckBlur(false)
         return
      }

      try {
         if (selectedDoc) {
            const brushingGroupRef = doc(db, 'brushingGroups', selectedDoc)

            await updateDoc(brushingGroupRef, {
               brushing,
            })
         } else {
            await addDoc(collection(db, 'brushingGroups'), { brushing })
         }

         setSelectedDoc(null)
         loadBrushingGroups()
         setBrushing('')
         setError('')
      } catch (error) {
         console.error('Error adding document: ', error)
      }
   }

   const loadBrushingGroups = async () => {
      try {

         const querySnapshot = await getDocs(collection(db, 'brushingGroups'))
         const brushingGroups = querySnapshot.docs.map((doc, index) => ({
            id: doc.id,
            index: index + 1,
            ...doc.data(),
         }))
         setBrushingData(brushingGroups)
         setCheckBlur(false)
      } catch (error) {
         console.error('Error getting documents: ', error)
      }
   }

   const deleteBrushing = async () => {
      try {
         if (selectedRow) {
            setCheckBlur(true)
            await deleteDoc(doc(db, 'brushingGroups', selectedRow.id))
            setOpen(false)
            setSelectedRow(null)
            loadBrushingGroups()
         }
      } catch (error) {
         console.error('Error removing document: ', error)
      }
   }

   const handleClickGetOneDoc = async (selectedDoc) => {
      try {
         const { row } = selectedDoc
         setBrushing(row.brushing)
         setSelectedDoc(row.id)
      } catch (error) {
         console.log(error)
      }
   }



   useLayoutEffect(() => {
      loadBrushingGroups()
      setCheckBlur(true)
   },[])

   const columns = [
      { field: 'index', headerName: 'ID', flex: 1 },
      { field: 'brushing', headerName: 'Brushing Group', flex: 3 },
      {
         field: 'action',
         headerName: 'Action',
         flex: 1,
         renderCell: (params) => {
            return (
               <Fragment>
                  <DeleteIcon
                     className='divListDelete'
                     onClick={() => handleClickOpen(params)}
                     sx={{ mx: 1 }}
                  />
                  <EditNoteIcon
                     sx={{ mx: 1 }}
                     onClick={() => handleClickGetOneDoc(params)}
                  />
               </Fragment>
            )
         },
      },
   ]

   return (
      <>
         {checkLoad ? (
            <FullPageLoader />
         ) : (
            <Box>
               <div>
                  <Typography
                     variant='h4'
                     gutterBottom
                  >
                     Brushing Type
                  </Typography>
                  <form onSubmit={addBrushing}>
                     <Box
                        sx={{
                           '& > :not(style)': { m: 4, width: '100%' },
                        }}
                        noValidate
                        autoComplete='off'
                     >
                        <Container maxWidth='sm'>
                           <Stack
                              spacing={2}
                              direction='row'
                           >
                              <TextField
                                 id='outlined-basic'
                                 label='Brushing'
                                 autoComplete='off'
                                 variant='outlined'
                                 value={brushing}
                                 onChange={(e) => {
                                    setBrushing(e.target.value)
                                    setError('')
                                 }}
                              />
                              <Button
                                 variant='contained'
                                 sx={{ width: 150 }}
                                 type='submit'
                              >
                                 Submit
                              </Button>
                           </Stack>
                           {error && (
                              <Typography color='error'>{error}</Typography>
                           )}
                        </Container>
                     </Box>
                  </form>
                  <div style={{ height: 400, width: '100%' }}>
                     <DataGrid
                        rows={brushingData}
                        columns={columns}
                        initialState={{
                           pagination: {
                              paginationModel: { page: 0, pageSize: 5 },
                           },
                        }}
                        pageSizeOptions={[5, 10]}
                     />
                  </div>
               </div>
               <Dialog
                  open={open}
                  onClose={handleClose}
                  aria-labelledby='alert-dialog-title'
                  aria-describedby='alert-dialog-description'
               >
                  <DialogTitle id='alert-dialog-title'>
                     {'Confirm Delete'}
                  </DialogTitle>
                  <DialogContent>
                     <DialogContentText id='alert-dialog-description'>
                        Are you sure to delete this user permanently
                     </DialogContentText>
                  </DialogContent>
                  <DialogActions>
                     <Button onClick={handleClose}>Disagree</Button>
                     <Button
                        onClick={deleteBrushing}
                        autoFocus
                     >
                        Agree
                     </Button>
                  </DialogActions>
               </Dialog>
            </Box>
         )}
      </>
   )
}

export default AgeGroup
