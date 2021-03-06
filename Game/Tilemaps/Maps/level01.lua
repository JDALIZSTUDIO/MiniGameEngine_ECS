return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.7.2",
  orientation = "orthogonal",
  renderorder = "left-up",
  width = 17,
  height = 7,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 5,
  nextobjectid = 21,
  properties = {},
  tilesets = {
    {
      name = "newTerrain32x32",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 16,
      image = "newTerrain32x32.png",
      imagewidth = 512,
      imageheight = 512,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      wangsets = {},
      tilecount = 256,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 17,
      height = 7,
      id = 1,
      name = "ground",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["Depth"] = 0
      },
      encoding = "lua",
      data = {
        49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49,
        49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49,
        49, 49, 49, 49, 49, 49, 82, 83, 49, 49, 49, 49, 49, 99, 50, 49, 49,
        49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 67, 49, 49, 49,
        49, 98, 83, 49, 49, 49, 49, 49, 49, 98, 83, 49, 49, 49, 49, 83, 49,
        49, 49, 49, 49, 49, 97, 65, 49, 49, 49, 49, 49, 82, 49, 49, 82, 49,
        49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 17,
      height = 7,
      id = 2,
      name = "walls",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["Depth"] = 0
      },
      encoding = "lua",
      data = {
        18, 18, 18, 18, 4, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 6,
        4, 34, 34, 34, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17,
        19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17,
        19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17,
        19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17,
        36, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17,
        18, 18, 18, 18, 36, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 38
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 17,
      height = 7,
      id = 3,
      name = "collisions",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["Depth"] = 0,
        ["Solid"] = true
      },
      encoding = "lua",
      data = {
        241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241,
        241, 241, 241, 241, 241, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 241,
        241, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 241,
        241, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 241,
        241, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 241,
        241, 241, 241, 241, 241, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 241,
        241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241, 241
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "objects",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 3,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 64,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 64,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "brickWall",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 64,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 212,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 96,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 210,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 96,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 210,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 210,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 160,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 210,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 210,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "block",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 160,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 210,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "barrel",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 214,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "barrel",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 64,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 214,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "crate",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 64,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 216,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "spawner",
          type = "",
          shape = "rectangle",
          x = 448,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 244,
          visible = true,
          properties = {}
        },
        {
          id = 1,
          name = "player",
          type = "",
          shape = "rectangle",
          x = 64,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 242,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
