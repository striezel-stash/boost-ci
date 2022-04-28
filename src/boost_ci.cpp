//
// Copyright (c) 2022 Alexander Grund
//
// Use, modification and distribution is subject to the Boost Software License,
// Version 1.0. (See accompanying file LICENSE_1_0.txt or copy at
// http://www.boost.org/LICENSE_1_0.txt)

#define BOOST_BOOST_CI_SOURCE

#include <boost/boost-ci/boost_ci.hpp>
// Just some dependency on another Boost library
#include <boost/atomic/atomic.hpp>

namespace boost
{
  namespace boost_ci
  {
    // Some function to test
    int get_answer(const bool isMsvc)
    {
      boost::atomic_int answer;
      // Specifically crafted condition to check for coverage from MSVC and non MSVC builds
      if(isMsvc)
      {
        answer = 21;
      } else
      {
        answer = 42;
      }
#ifdef BOOST_NO_CXX11_SMART_PTR
      return answer;
#else
      // Just use some stdlib feature combined with a Boost.Config feature as demonstration
      auto ptr = std::unique_ptr<int>(new int(answer));
      return *ptr;
#endif
    }
  }
}
