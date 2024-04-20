import React, { useLayoutEffect, useState } from 'react'
import { DataGrid } from '@mui/x-data-grid'
import {
  Box,
  Button,
  Stack,
  TextField,
  Typography,
  Dialog,
  DialogActions,
  DialogContent,
  DialogContentText,
  DialogTitle,
  Avatar,
  CardMedia,
} from '@mui/material'
import CloudUploadIcon from '@mui/icons-material/CloudUpload'
import { styled } from '@mui/material/styles'
import DeleteIcon from '@mui/icons-material/Delete'
import VisibilityIcon from '@mui/icons-material/Visibility'
import { db, storage } from '../../config/firebase'
import { addDoc, collection, getDocs, deleteDoc, doc } from 'firebase/firestore'
import {
  ref,
  uploadBytesResumable,
  getDownloadURL,
  deleteObject,
} from 'firebase/storage'
import FullPageLoader from './FullPageLoader'

const UploadVideos = () => {
  const [open, setOpen] = useState(false)
  const [openPlayer, setOpenPlayer] = useState(false)
  const [openImagePlayer, setOpenImagePlayer] = useState(false)
  const [uploadVideosData, setUploadVideosData] = useState([])
  const [videoTitle, setVideoTitle] = useState('')
  const [video, setVideo] = useState(null)
  const [photo, setPhoto] = useState(null)
  const [selectedRow, setSelectedRow] = useState(null)
  const [singleVideo, setSingleVideo] = useState([])
  const [singlePhoto, setSinglePhoto] = useState([])
  const [checkLoad, setCheckBlur] = useState(false)

  const [videoTitleError, setVideoTitleError] = useState('')

  const handleClickOpen = (params) => {
    setSelectedRow(params)
    setOpen(true)
  }
  const handleClickOpenVideo = (params) => {
    setSingleVideo(params.row.videoUrl)
    setOpenPlayer(true)
  }

  const handleClickOpenImage = (params) => {
    setSinglePhoto(params.row.imgUrl)
    setOpenImagePlayer(true)
  }
  const handleCloseImagePlayer = () => {
    setOpenImagePlayer(false)
  }

  const handleClose = () => {
    setOpen(false)
  }

  const handleClosePlayer = () => {
    setOpenPlayer(false)
  }

  

  const generateRandomName = (prefix) => {
    const randomString = Math.random().toString(36).substring(2, 8)
    const timestamp = new Date().getTime()
    return `${prefix}_${randomString}_${timestamp}`
  }

  const addUploadVideo = async () => {
    setCheckBlur(true)
    if (!videoTitle || !photo || !video ) {
      setVideoTitleError('All Fields required')
      setCheckBlur(false)
      return
    }

    try {
      const type = video.type
      const imgType = photo.type
      const metadata = {
        contentType: video.type,
      }
      const imgmetaData = {
        contentType: photo.type,
      }

      if (!type || !type.startsWith('video/')) {
        alert('Invalid file type. Please upload a video.')
        setCheckBlur(true)
        return
      }

      if (!imgType || !imgType.startsWith('image/')) {
        alert('Invalid file type. Please upload a Image.')
        setCheckBlur(true)
        return
      }

      const randomName = generateRandomName(video.name)
      const randomImageName = generateRandomName(photo.name)
      const storageRef = ref(storage, `Video/${randomName}`)
      const storageImgRef = ref(storage, `Images/${randomImageName}`)

      await uploadBytesResumable(storageRef, video, metadata)
      const videoUrl = await getDownloadURL(storageRef).then((downloadURL) => {
        return downloadURL
      })

      await uploadBytesResumable(storageImgRef, photo, imgmetaData)
      const imgUrl = await getDownloadURL(storageImgRef).then((downloadURL) => {
        return downloadURL
      })
      console.log(imgUrl)

      await addDoc(collection(db, 'uploadVideo'), {
        videoTitle,
        videoUrl,
        imgUrl,
      })
      loadUploadVideo()
      setVideoTitle('')
      setVideo('')
      setPhoto('')
    } catch (error) {
      console.error('Error adding document: ', error)
    }
  }

  const loadUploadVideo = async () => {
    try {
      const querySnapshot = await getDocs(collection(db, 'uploadVideo'))
      const uploadVideo = querySnapshot.docs.map((doc, index) => ({
        id: doc.id,
        index: index + 1,
        ...doc.data(),
      }))
      setCheckBlur(false)
      setUploadVideosData(uploadVideo)
    } catch (error) {
      console.error('Error getting documents: ', error)
    }
  }

  const deleteUploadVideo = async () => {
    try {
      if (selectedRow) {
        setCheckBlur(true)
        const filePath = selectedRow.row.videoUrl
        const imgPath = selectedRow.row.imgUrl
        const fileRef = ref(storage, filePath)
        const imgRef = ref(storage, imgPath)
        await deleteObject(fileRef)
        await deleteObject(imgRef)
        await deleteDoc(doc(db, 'uploadVideo', selectedRow.id))
        setOpen(false)
        setSelectedRow(null)
        loadUploadVideo()
      }
    } catch (error) {
      console.error('Error removing document: ', error)
    }
  }

  useLayoutEffect(() => {
    setCheckBlur(true)
    loadUploadVideo()
  }, [])

  const columns = [
    { field: 'index', headerName: 'ID', flex: 1 },

    {
      field: 'videoTitle',
      headerName: 'Video Title',
      flex: 3,
    },
    {
      field: 'videoUrl',
      headerName: 'Videos',
      flex: 3,
      renderCell: (params) => {
        return (
          <>
            <VisibilityIcon
              className="divListDelete"
              onClick={() => handleClickOpenVideo(params)}
            />
          </>
        )
      },
    },
    {
      field: 'imgUrl',
      headerName: 'ThumbNail',
      flex: 3,
      renderCell: (params) => {
        return (
          <>
            <Avatar
              src={params.value}
              className="divListDelete"
              onClick={() => handleClickOpenImage(params)}
            />
          </>
        )
      },
    },
    {
      field: 'action',
      headerName: 'Action',
      flex: 1,
      renderCell: (params) => {
        return (
          <>
            <DeleteIcon
              className="divListDelete"
              onClick={() => handleClickOpen(params)}
            />
          </>
        )
      },
    },
  ]

  const VisuallyHiddenInput = styled('input')({
    clip: 'rect(0 0 0 0)',
    clipPath: 'inset(50%)',
    height: 1,
    overflow: 'hidden',
    position: 'absolute',
    bottom: 0,
    left: 0,
    whiteSpace: 'nowrap',
    width: 1,
  })

  return (
    <>
      {checkLoad ? (
        <FullPageLoader />
      ) : (
        <Box>
          <div>
            <Typography variant="h4" gutterBottom>
              Upload Video
            </Typography>
            <Box
              component="form"
              sx={{
                '& > :not(style)': { m: 4, width: '100%' },
              }}
              noValidate
              autoComplete="off"
            >
              <Stack spacing={2} direction="row">
                <TextField
                  id="outlined-basic"
                  autoComplete="off"
                  label="Video Title"
                  variant="outlined"
                  sx={{ width: '40%', minWidth: 150 }}
                  multiline
                  maxRows={3}
                  value={videoTitle}
                  onChange={(event) => {
                    setVideoTitle(event.target.value);
                    setVideoTitleError('')
                  }}
                />

                <Button
                  component="label"
                  variant="contained"
                  startIcon={<CloudUploadIcon />}
                  onChange={(event) =>{ setPhoto(event.target.files[0]);setVideoTitleError('')}}
                  sx={{ maxHeight: 50 }}
                >
                  {photo
                    ? photo.name.length > 20
                      ? photo.name.slice(0, 20) + '...'
                      : photo.name
                    : 'thumbnail'}

                  <VisuallyHiddenInput type="file" />
                </Button>
                <Button
                  component="label"
                  variant="contained"
                  startIcon={<CloudUploadIcon />}
                  onChange={(event) =>{ setVideo(event.target.files[0]);setVideoTitleError('')}}
                  sx={{ maxHeight: 50 }}

                >
                  {video
                    ? video.name.length > 20
                      ? video.name.slice(0, 20) + '...'
                      : video.name
                    : 'Video'}

                  <VisuallyHiddenInput type="file" />
                </Button>

                <Button
                  variant="contained"
                  sx={{ width: 150, maxHeight: 50 }}
                  onClick={addUploadVideo}
                >
                  Submit
                </Button>
              </Stack>
              {videoTitleError && (
                              <Typography color='error'>{videoTitleError}</Typography>
                           )}
            </Box>
            <div style={{ height: 400, width: '100%' }}>
              <DataGrid
                rows={uploadVideosData}
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
            aria-labelledby="alert-dialog-title"
            aria-describedby="alert-dialog-description"
          >
            <DialogTitle id="alert-dialog-title">
              {'Confirm Delete'}
            </DialogTitle>
            <DialogContent>
              <DialogContentText id="alert-dialog-description">
                Are you sure to delete this user permanenently
              </DialogContentText>
            </DialogContent>
            <DialogActions>
              <Button onClick={handleClose}>Disagree</Button>
              <Button onClick={deleteUploadVideo} autoFocus>
                Agree
              </Button>
            </DialogActions>
          </Dialog>
          <Dialog
            open={openPlayer}
            onClose={handleClosePlayer}
            aria-labelledby="responsive-dialog-title"
          >
            <video controls width="300px" height="auto">
              <source src={singleVideo} />
              Your browser does not support the video tag.
            </video>
            <Button onClick={handleClosePlayer} sx={{ color: 'black' }}>
              Close
            </Button>
          </Dialog>

          <Dialog
            open={openImagePlayer}
            onClose={handleCloseImagePlayer}
            aria-labelledby="responsive-dialog-title"
          >
            {console.log(singlePhoto)}
            <CardMedia
              image={singlePhoto}
              sx={{ width: 600, minHeight: 500 }}
            />
            <Button onClick={handleCloseImagePlayer} sx={{ color: 'black' }}>
              Close
            </Button>
          </Dialog>
        </Box>
      )}
    </>
  )
}

export default UploadVideos
