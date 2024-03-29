package com.fastcampus.ch4.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.fastcampus.ch4.domain.BoardDto;
import com.fastcampus.ch4.domain.PageHandler;
import com.fastcampus.ch4.domain.SearchCondition;
import com.fastcampus.ch4.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/board")
public class BoardController {
    
    @Autowired
    BoardService boardService;

    @PostMapping("/modify")
    public String modify(Integer page, Integer pageSize,BoardDto boardDto ,Model m, HttpSession session, RedirectAttributes rattr){
        String writer = (String)session.getAttribute("id");
        boardDto.setWriter(writer);

        try {
            rattr.addAttribute("page",page);
            rattr.addAttribute("pageSize",pageSize);

            int rowCnt = boardService.modify(boardDto);

            if(rowCnt!=1) throw new Exception("Modify failed");

            rattr.addFlashAttribute("msg","MOD_OK");

            return "redirect:/board/list";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute(boardDto);
            m.addAttribute("page", page);
            m.addAttribute("pageSize", pageSize);
            m.addAttribute("msg", "MOD_ERR");

            return "board";
        }

    }

    @GetMapping("/write")
    public String write(Model m){
        m.addAttribute("mode","new");

        return "board"; // board.jsp를 읽기와 쓰기에 사용 , 쓰기일때 mode=new
    }

    @PostMapping("/write")
    public String write(BoardDto boardDto ,Model m, HttpSession session, RedirectAttributes rattr){
        String writer = (String)session.getAttribute("id");
        boardDto.setWriter(writer);

        try {
            int rowCnt = boardService.write(boardDto);

            if(rowCnt!=1) throw new Exception("Write failed");

            rattr.addFlashAttribute("msg","WRT_OK");

            return "redirect:/board/list";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("boardDto",boardDto);
            rattr.addFlashAttribute("msg","WRT_ERR");

            return "board";
        }

    }

    //RedirectAttributes : 1회성 모델 , session을 이용
    @PostMapping("/remove")
    public String remove(Integer bno, Integer page, Integer pageSize, HttpSession session , RedirectAttributes rattr){
        String writer = (String)session.getAttribute("id");

        try {

            rattr.addAttribute("page",page);
            rattr.addAttribute("pageSize",pageSize);

            int rowCnt = boardService.remove(bno, writer);

            if(rowCnt!=1){ // 1이 아니면 예외 발생시킴
                throw new Exception("board remove error");
            }
            rattr.addFlashAttribute("msg","DEL_OK");

        } catch (Exception e) {
            e.printStackTrace();
            rattr.addFlashAttribute("msg","DEL_ERR");
        }


        return "redirect:/board/list";
    }


    // 해당 게시물을 누르면 read로 mapping
    @GetMapping("/read")
    public String read(Integer bno , Integer page, Integer pageSize, Model m){
        try {
            // boardService.read를 통해 해당 bno 번호의 게시물을 읽어서 Dto에 저장해서 받아옴
            BoardDto boardDto = boardService.read(bno);

            // 받아온 BoardDto를 모델 m에 저장해서 return board 즉, board.jsp로 넘겨줌
            m.addAttribute("boardDto", boardDto);
            //m.addAttribute(boardDto); 위랑 동일
            m.addAttribute("page",page);
            m.addAttribute("pageSize",pageSize);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "board";
    }

    @GetMapping("/list")
    public String list(SearchCondition sc, Model m, HttpServletRequest request) {
        if(!loginCheck(request))
            return "redirect:/login/login?toURL="+request.getRequestURL();  // 로그인을 안했으면 로그인 화면으로 이동
        try {

            int totalCnt = boardService.getSearchResultCnt(sc);
            m.addAttribute("totalCnt", totalCnt);
            PageHandler pageHandler = new PageHandler(totalCnt, sc);

            List<BoardDto> list = boardService.getSearchResultPage(sc);
            m.addAttribute("list",list);
            m.addAttribute("ph", pageHandler);
            m.addAttribute("page",sc.getPage());
            m.addAttribute("pageSize",sc.getPageSize());

            Instant startOfToday = LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant();
            m.addAttribute("startOfToday",startOfToday.toEpochMilli());

        }catch(Exception e){
            e.printStackTrace();
            m.addAttribute("msg", "LIST_ERR");
            m.addAttribute("totalCnt",0);
        }

        return "boardList"; // 로그인을 한 상태이면, 게시판 화면으로 이동
    }

    private boolean loginCheck(HttpServletRequest request) {
        // 1. 세션을 얻어서
        HttpSession session = request.getSession();
        // 2. 세션에 id가 있는지 확인, 있으면 true를 반환
        return session.getAttribute("id")!=null;
    }
}